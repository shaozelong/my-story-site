# 使用包含指定版本 Hugo Extended 的官方镜像
FROM klakegg/hugo:0.155.2-extended-alpine AS builder

# 设置容器内的工作目录
WORKDIR /src
# 将整个项目代码复制到容器中
COPY . .

# 执行 Hugo 构建，生成静态文件到 ‘public’ 目录
RUN hugo --gc --minify --destination public

# （可选）第二阶段：使用极简的 Nginx 镜像来服务文件
# 这能确保最终镜像只包含运行所需的文件，更安全轻量。
FROM nginx:alpine
# 从构建阶段复制生成的静态文件
COPY --from=builder /src/public /usr/share/nginx/html