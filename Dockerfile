FROM node:14.21.0 AS nodejs
FROM ruby:3.0.2

RUN mkdir /opt/rpnet
WORKDIR /opt/rpnet
ADD ./ ./

RUN gem install bundler
RUN bundle install

COPY --from=nodejs /usr/local/bin/node /usr/local/bin/
COPY --from=nodejs /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodejs /opt/ /opt/

RUN ln -sf /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -sf ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -sf ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
    && ln -sf /opt/yarn*/bin/yarn /usr/local/bin/yarn \
    && ln -sf /opt/yarn*/bin/yarnpkg /usr/local/bin/yarnpkg

RUN yarn install

CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]
