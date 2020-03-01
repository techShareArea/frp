FROM debian:stretch-slim

LABEL maintainer="firMament<1107906657@qq.com>"

RUN groupadd --gid 1000 frp && \
    useradd --uid 1000 --gid 1000 frp && \
    mkdir -p /frp/ && \
    chown -R 1000:1000 /frp && \
    echo 'Asia/Shanghai' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV FRPC_SERVER_ADDR=10.0.5.225 \
    FRPC_SERVER_PORT=7000 \
    FRPC_TOKEN=qshlsmmzd \
    FRPC_ADMIN_ADDR=127.0.0.1 \
    FRPC_ADMIN_PORT=7400 \
    FRPC_ADMIN_USER=admin \
    FRPC_ADMIN_PWD=qshlsmmzd \
    FRPC_USER=default \
    FRPC_X_MODE=normal \
    FRPC_SSH_SK=qshlsmmzd \
    FRPC_SSH_REMOTE_PORT=36969 \
    FRPC_SSH_LOCAL_IP=127.0.0.1 \
    FRPC_SSH_LOCAL_PORT=22 \
    FRPC_SSH_BIND_ADDR=0.0.0.0 \
    FRPC_SSH_BIND_PORT=22000 \
    FRPC_SSH_USE_ENCRYPTION=true \
    FRPC_SSH_USE_COMPRESSION=true

COPY frpc /frp/frpc
COPY frpc.ini /frp/frpc.ini
COPY frpc-stcp.ini /frp/frpc-stcp.ini
COPY frpc-visitor.ini /frp/frpc-visitor.ini
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /frp/frpc /entrypoint.sh

USER 1000

EXPOSE ${FRPC_ADMIN_PORT}

ENTRYPOINT ["/entrypoint.sh"]
