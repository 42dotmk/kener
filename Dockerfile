FROM node:21-alpine

WORKDIR /app

COPY . .

RUN mkdir -p /app/static/kener
ENV PUBLIC_KENER_FOLDER=/app/static/kener

ENV MONITOR_YAML_PATH=/app/config/monitors.yaml
ENV SITE_YAML_PATH=/app/config/site.yaml 

RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "serve"]
