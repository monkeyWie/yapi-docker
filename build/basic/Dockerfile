FROM node:10-buster
WORKDIR /yapi
RUN git clone --progress --depth 1 --branch v1.9.2 https://github.com/YMFE/yapi.git vendor \
        && cd vendor \
        && npm install --registry https://registry.npm.taobao.org
COPY ./config.json ./
RUN cd vendor && npm run build-client
COPY ./run.sh ./
CMD ["sh","run.sh"]