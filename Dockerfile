FROM node:14.17 AS base
WORKDIR /app

COPY package*.json ./
RUN echo "Node.js version:" && \
  node -v && \
  echo "NPM version:" && \
  npm -v && \
  npm install && \
  npm audit fix

COPY . .
RUN npm run build && \
  npm cache clean --force && \
  rm -rf app/src

FROM node:14.17-alpine3.13
WORKDIR /app
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/dist ./dist

ENV abc=hello
EXPOSE 3000
ENTRYPOINT ["node", "dist/main.js"]