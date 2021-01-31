# Multi step build process

# for AWS remove named phases
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# new from statment starts new phase
FROM nginx
# for AWS (--from=0)
# /usr/share/nginx/html - from nginx documentation
COPY --from=builder /app/build /usr/share/nginx/html
# docker run -p 8080:80 <image> (nginx default port is 80)
