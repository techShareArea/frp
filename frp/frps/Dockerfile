FROM debian:stretch-slim

LABEL maintainer="firMament<1107906657@qq.com>"

RUN groupadd --gid 1000 frp && \
    useradd --uid 1000 --gid 1000 frp && \
    mkdir -p /frp/ && \
    chown -R 1000:1000 /frp && \
    echo 'Asia/Shanghai' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV FRPS_BIND_PORT=7000 \
    FRPS_DASHBOARD_USER=admin \
    FRPS_DASHBOARD_PORT=7500 \
    FRPS_DASHBOARD_PWD=qshlsmmzd \
    FRPS_ALLOW_PORTS=30000-39999 \
    FRPS_TOKEN=qshlsmmzd

COPY frps /frp/frps
COPY frps.ini /frp/frps.ini
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /frp/frps /entrypoint.sh

USER 1000

EXPOSE ${FRPS_BIND_PORT} ${FRPS_DASHBOARD_PORT}

ENTRYPOINT ["/entrypoint.sh"]
