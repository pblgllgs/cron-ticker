FROM node:19.4-alpine3.17 AS deps
WORKDIR /app
COPY package.json ./
RUN npm install


FROM node:19.4-alpine3.17 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run test

FROM node:19.4-alpine3.17 AS prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod


FROM node:19.4-alpine3.17 AS runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY /tasks ./tasks
COPY app.js ./
CMD ["node", "app.js"]