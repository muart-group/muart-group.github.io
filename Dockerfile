FROM node:lts-alpine

ENV NPM_CONFIG_LOGLEVEL=warn
ENV NPM_CONFIG_COLOR=false

EXPOSE 3000

WORKDIR /app
RUN chown -R node:node /app
USER node

COPY --chown=node:node package.json yarn.lock /app
RUN yarn install

COPY --chown=node:node . /app

CMD ["yarn", "start", "--host", "0.0.0.0"]
