#!/usr/bin/env bash

IMG=techsharearea/frpc:2020

docker pull ${IMG}

docker run -d \
  --name frpc \
  --restart always \
  -p 7400:7400 \
  -e FRPC_TOKEN=codeman \
  -e FRPC_SERVER_ADDR=my-aliyun-ecs \
  -e FRPC_SERVER_PORT=7000 \
  -e FRPC_USER=demo \
  -e FRPC_X_MODE=normal \
  -e FRPC_SSH_LOCAL_IP=10.0.5.225 \
  -e FRPC_SSH_REMOTE_PORT=33333 \
  --add-host my-aliyun-ecs:47.115.42.204 \
  ${IMG}

docker logs -f frpc
