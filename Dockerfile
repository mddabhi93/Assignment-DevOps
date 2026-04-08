FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
FROM node:18-alpine
WORKDIR /app
RUN addgroup -S m-group && m-user -S m-user -G m-group
COPY --from=builder /app ./
RUN chown -R m-user:m-group /app
USER m-user
EXPOSE 3000
CMD ["node", "server.js"]
