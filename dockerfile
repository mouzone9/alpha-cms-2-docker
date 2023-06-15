FROM node:16

ARG NODE_ENV=16
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn config set network-timeout 600000 -g && yarn install
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN ["yarn", "build"]
EXPOSE 1337
CMD ["yarn", "develop"]