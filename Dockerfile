# 选择一个基础镜像，比如 Debian 或 Alpine
FROM debian:bullseye-slim AS builder

# 设置 Hugo 版本和架构
ARG HUGO_VERSION="0.146.0" # 这里需要填写一个 >= 0.146.0 的实际版本号
ARG TARGETARCH="arm64" # 根据你的构建环境可能是 amd64 或 arm64

WORKDIR /src

# 安装 wget 和 ca-certificates (如果基础镜像没有)
RUN apt-get update && apt-get install -y wget ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 下载指定版本的 Hugo Extended (.deb 包)
# **注意:** 你需要去 Hugo GitHub Releases 页面找到对应版本的 .deb 文件下载链接！
RUN wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.deb" -O hugo.deb && \
    dpkg -i hugo.deb && \
    rm hugo.deb

# 复制项目文件
COPY . .

# (可选) 安装 Go 环境以下载模块，如果基础镜像没有 Go
# 如果 Hugo 下载模块需要 Go，你可能还需要安装 Go
RUN apt-get update && apt-get install -y golang-go --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 设置环境变量并下载模块
ENV HUGO_ENV=production
RUN hugo version # 检查安装的 Hugo 版本
RUN hugo mod init myblog # 如果还没有 go.mod，需要初始化 (myblog 是示例名)
RUN hugo mod get # 下载主题模块

# 构建博客
RUN hugo --minify

# ---------------- 第二阶段保持不变 ----------------
FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]