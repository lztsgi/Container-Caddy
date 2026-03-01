# 提取官方可执行文件
FROM adguard/adguardhome:latest AS builder

# 构建带网络工具的 Alpine 镜像
FROM alpine:latest
RUN apk add --no-cache iptables iproute2 tzdata

# 拷贝 AH 核心文件与预备脚本
COPY --from=builder /opt/adguardhome /opt/adguardhome
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露端口与工作目录
EXPOSE 53/tcp 53/udp 80/tcp 443/tcp 3000/tcp
VOLUME ["/opt/adguardhome/work", "/opt/adguardhome/conf"]

ENTRYPOINT ["/entrypoint.sh"]
