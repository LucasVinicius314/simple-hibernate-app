FROM node as builder

WORKDIR /usr/app

COPY package.json yarn.lock tsconfig.json ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM node:slim

WORKDIR /usr/app

COPY package.json yarn.lock tsconfig.json ./

COPY --from=builder /usr/app/build ./build

RUN yarn install --production --frozen-lockfile

EXPOSE 80
CMD [ "node", "build/index.js" ]
