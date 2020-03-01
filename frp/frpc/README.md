### frps的镜像制作与部署说明
本方案中存储镜像仓库采取的是dockerhub

#### 镜像制作
前言:本服务器环境基于centos7.5，系统环境(含docker环境，关闭firewalld及selinux等)，请自行准备。

##### 注册dockerhub使用id
进入[dockerhub](https://hub.docker.com)网址注册，申请好后，实现服务器到dockerhub的免密登陆，方式有如下两种，请自行选择       

1.在服务器中执行如下命令                
> docker login --username=your dockerhub-id     
Password:           #自行输入自己id的密码        

2.在服务器中执行如下命令        
```
mkdir -p /root/.docker  
cat > /root/.docker/config.json <<-EOF
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "xxxxxx"
        }
    }
}
EOF
```
注:auth的值为your id:your password的base64编码值        
生成值，可参考如下:
> echo 'go:go' | base64     

##### 构建镜像并推送值dockerhub仓库
> bash build-frpc-docker-to-dockerhub.sh        

#### 部署       
前言:frpc镜像已在dockerhub仓库中，可以任意地方部署(前提是联网的情况下)
本方案采取的是frps服务端部署在aliyun，ecs实例安全组开放7000跟7500端口，也可在其它云商环境，亦可在公司内网。        
注:在公司内网的情况下，应根据公司公网ip是否会变动来具体考量        
> 1.公网ip不会变，frpc客户端可给定参数:FRPC_SERVER_ADDR=公司公网ip;  
> 2.公网ip会变，公司内网做好规则处理，frpc客户端可给定参数:FRPC_SERVER_ADDR=设定的域名；        
> 3.配置好规则，frpc客户端给定参数:FRPC_SERVER_ADDR=设定的域名(推荐)。      

##### 部署方式一:
需要的环境变量已植入，如若不想替换，可直接运行如下命令:     
> docker run -d -p 7400:7400 -e FRPC_SERVER_ADDR=47.115.42.204 -e FRPC_SSH_LOCAL_IP=10.0.5.225 frpc              

注:FRPC_SSH_LOCAL_IP为客户端宿主机ip

web访问frps-dashboard-->公网ip:7500     
输入账户:admin，密码:qshlsmmzd进入dashboard

##### 服务端远程客户端ssh连接客户端(服务端的服务器上操作)
```
ssh -oPort=36969 root@`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' frps`
```

##### 部署方式二:
通过环境变量的形式替换掉原先的值，如下(这里以frpc的normal的模式做讲解):
> bash frpc.sh      

说明:
```
docker run -d \
  --name frpc \
  --restart always \
  -p 7400:7400 \
  -e FRPC_TOKEN=codeman \                   #客户端TOKEN值必须与服务端一致      
  -e FRPC_SERVER_ADDR=my-aliyun-ecs \       #服务端的主机名设为my-aliyun-ecs,执行命令:hostnamectl set-hostname my-aliyun-ecs        
  -e FRPC_SERVER_PORT=7000 \                #与服务端的PORT一致
  -e FRPC_USER=demo \                       #自定义FRPC_USER
  -e FRPC_X_MODE=normal \
  -e FRPC_SSH_LOCAL_IP=10.0.5.225 \         #客户端宿主机IP
  -e FRPC_SSH_REMOTE_PORT=33333 \           #客户端暴露的端口，在服务端用于ssh连接      
  --add-host my-aliyun-ecs:47.115.42.204 \  #容器中/etc/hosts文件增加47.115.42.204  my-aliyun-ecs记录
  techsharearea/frps:2020   
```
注:需要替换更多，请自行调整     

web访问frps-dashboard-->公网ip:7500     
输入账户:admin，密码:123456进入dashboard，即可看见TCP栏添加的客户端的相关信息，如图:dashboard-info所示       

##### 服务端远程客户端ssh连接客户端(服务端的服务器上操作)
```
ssh -oPort=33333 root@`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' frps`
```     

##### 域名方式
如需要使用FRPC_SERVER_ADDR=域名(如:frp.view.top等)，请自行处理，这里不再赘述。      

#### frp文档参阅
[frp](https://github.com/fatedier/frp)      