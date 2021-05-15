FROM node:14-alpine as build

WORKDIR /app

COPY . . 

RUN ls && ls ./public

RUN npm i && npm run build

FROM nginx:1.20-alpine

COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 80 443