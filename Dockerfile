# 使用 Node.js v20.16.0 作为基础镜像
FROM node:20.16.0-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖包，使用指定的镜像源

RUN npm cache clean --force
RUN npm install



# 复制项目的所有文件
COPY . .

# 暴露服务端口，根据 README 推测为 3000
EXPOSE 3000

# 启动服务
CMD ["npm", "run", "start"]