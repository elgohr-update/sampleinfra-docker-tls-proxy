FROM nginx:1-alpine

ENV LISTEN_PORT 443
ENV UPSTREAM_HOST localhost
ENV UPSTREAM_PORT 80
ENV SELF_SIGNED false
ENV FORCE_HTTPS false
ENV ENABLE_WEBSOCKET false
ENV ENABLE_HTTP2 false
ENV SERVER_NAME _
ENV MAX_BODY_SIZE 1m

RUN apk update && \
  apk add --no-cache --upgrade nginx openssl && \
  rm -rf /var/lib/apt/lists/* /etc/nginx/conf.d/*

COPY entry.sh /usr/local/bin/entry.sh
COPY nginx/conf.d /etc/nginx/conf.d

ENTRYPOINT ["/usr/local/bin/entry.sh"]

CMD ["nginx", "-g", "daemon off;"]
