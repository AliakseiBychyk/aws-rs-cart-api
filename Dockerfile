FROM node:14.17-alpine3.12

ARG NODE_ENV=production

ENV NODE_ENV=${NODE_ENV}

WORKDIR /app/

COPY ["package*.json", "tsconfig.json", "./"]

RUN echo "NODE_ENV: ${NODE_ENV}" && \
  node -v && \
  npm -v && \
  npm install

COPY . .

RUN npm build && \
  npm cache clean --force

RUN rm -rf /usr/src/app/src/

USER node
EXPOSE 3000
ENTRYPOINT [ "node", "app/main.js" ]