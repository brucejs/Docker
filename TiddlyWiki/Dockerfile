FROM node

RUN npm install -g tiddlywiki; \
    tiddlywiki /wiki --init server

VOLUME /wiki

WORKDIR /wiki

EXPOSE 8080

CMD ["/usr/local/bin/tiddlywiki", "/wiki", "--listen", "host=0.0.0.0"]
