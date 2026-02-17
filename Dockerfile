FROM alpine:latest

# 安装基础依赖
RUN apk add --no-cache ca-certificates tzdata curl tar libcap mailcap bash

# 创建目录结构
# /data/bin 用来挂载你的 disk1/mount/bin
RUN mkdir -p /etc/caddy /etc/ddns-go /var/lib/caddy /var/log/caddy /data/bin

# 拷贝脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root
EXPOSE 80 443 9876 2019

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]