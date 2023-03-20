FROM node:latest
WORKDIR /app
COPY . .
WORKDIR /app/examples/hello-world
RUN npm init -y && npm install
EXPOSE 3000
ENTRYPOINT ["node", "index.js"]
