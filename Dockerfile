FROM --platform=linux/amd64 node:19.4-alpine3.17
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run test
RUN rm -rf tests node_modules
RUN npm install --prod
CMD ["node", "app.js"]