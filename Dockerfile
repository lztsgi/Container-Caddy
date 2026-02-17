FROM alpine:latest

# 1. 安装基础依赖 (CA证书用于HTTPS, Timezone用于日志时间)
# 设置完时区后立即删除 tzdata 包以节省空间
RUN apk add --no-cache ca-certificates tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    mkdir -p /config /data /etc/caddy

# 2. 复制构建好的二进制文件 (由 Github Action 传入)
COPY caddy /usr/bin/caddy

# 3. 环境变量
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

# 4. 端口暴露
EXPOSE 80 443 2019

# 5. 启动命令
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
