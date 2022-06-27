FROM node:18 AS development

RUN mkdir -p /usr/app/server
WORKDIR /usr/app/server

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:18 as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/app/server

COPY package.json package-lock.json ./

RUN npm ci --only=production

COPY . .

COPY --from=development /usr/app/server/dist ./dist

CMD ["npm", "run", "start:prod"]
