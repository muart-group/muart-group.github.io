FROM node:lts-alpine

ENV NPM_CONFIG_LOGLEVEL=warn
ENV NPM_CONFIG_COLOR=false

EXPOSE 3000

WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn install

COPY . /app

CMD ["yarn", "start", "--host", "0.0.0.0", "--poll", "6001"]
