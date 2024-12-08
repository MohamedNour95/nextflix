FROM node:18.0.0-alpine AS build
WORKDIR /app
COPY . .
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm install && \
    npm run build

FROM node:18.0.0-alpine
WORKDIR /app
COPY --from=build /app .
ARG API_KEY
ENV TMDB_KEY=${API_KEY}
EXPOSE 3000
CMD [ "npm","start"]