#
# Client builder
#
FROM ubuntu:20.04 as client-builder

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl git wget unzip fonts-droid-fallback python3
RUN apt-get clean

RUN apt-get update && apt-get install -y build-essential
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

WORKDIR /usr/local/flutter

RUN flutter channel master

RUN git checkout f9972818f4e8bf464b378f0942a153fa391a0b7a

RUN flutter config --enable-web

WORKDIR /app

COPY ./client .

RUN flutter pub get

RUN flutter build web --release

#
# Builder
#
FROM node as builder

WORKDIR /usr/app

COPY ./server/package.json ./server/yarn.lock ./server/tsconfig.json ./

RUN yarn install --frozen-lockfile

COPY ./server .

RUN yarn build

#
# Runner
#
FROM node:slim

WORKDIR /usr/app

COPY ./server/package.json ./server/yarn.lock ./server/tsconfig.json ./

COPY --from=builder /usr/app/build ./build

COPY --from=client-builder /app/build/web /app/static

RUN chmod -R 777 /app/static

RUN yarn install --production --frozen-lockfile

EXPOSE 80
CMD [ "node", "build/index.js" ]
