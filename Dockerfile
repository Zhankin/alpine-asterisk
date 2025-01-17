FROM alpine:latest

MAINTAINER j3st3r

RUN apk add --update psqlodbc asterisk-odbc \
&&  apk add mysql-connector-odbc --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
&&  rm -rf /var/cache/apk/*

RUN apk add --update less curl sngrep ngrep \
      asterisk asterisk-cdr-mysql asterisk-curl asterisk-speex asterisk-sample-config \
&&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*


# start asterisk so it creates missing folders and initializes astdb
RUN asterisk && sleep 5

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]


