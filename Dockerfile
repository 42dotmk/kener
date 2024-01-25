FROM node:21-alpine as BUILD

WORKDIR /app

COPY . . 

RUN mkdir -p /app/static/kener
ENV PUBLIC_KENER_FOLDER=/app/static/kener

RUN npm install
RUN npm run build

FROM node:21-alpine

WORKDIR /app

COPY prod.js ./
COPY ./scripts ./scripts
COPY ./config ./config

COPY --from=BUILD /app/package*.json ./
COPY --from=BUILD /app/build ./build

RUN mkdir -p /app/static/kener
ENV PUBLIC_KENER_FOLDER=/app/static/kener

ENV NODE_ENV=production

RUN npm install express

EXPOSE 3000

CMD ["npm", "run", "serve"]
