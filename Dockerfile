FROM node:alpine AS builder

USER node

WORKDIR '/app'

COPY --chown=node:node package.json .

RUN npm install

RUN mkdir ./node_modules/.cache; chown -R node:node ./node_modules

COPY --chown=node:node ./ ./

RUN npm run build



FROM nginx

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html