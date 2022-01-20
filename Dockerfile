FROM node:14.15.4 as builder
ENV NODE_ENV = production
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]

USER 0
RUN npm ci --production

USER node
COPY src/. .

FROM node:14.15.4-slim
USER node
COPY --from=builder /app /app
CMD ["node", "server.js"]
