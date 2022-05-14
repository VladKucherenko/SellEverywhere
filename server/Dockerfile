FROM node:17.3.0-alpine AS development

RUN mkdir -p /usr/app/server
WORKDIR /usr/app/server

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM node:17.3.0-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/app/server

COPY package.json .

RUN npm install --only=production

COPY . .

COPY --from=development /usr/app/server/dist ./dist

CMD ["npm", "run", "start:prod"]
