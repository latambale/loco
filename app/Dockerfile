# Stage 1: Build stage
FROM node:18-alpine as build-stage

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

FROM node:18-alpine

WORKDIR /app

COPY --from=build-stage /app .

EXPOSE 80

CMD ["npm", "start"]
