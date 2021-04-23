FROM alpine:3.12

RUN apk add --update mysql mysql-client --no-cache \
&& rm -f /var/cache/apk/*

########### mysql ############

RUN mkdir -p /var/run/mysqld
COPY srcs/my.cnf /etc/my.cnf

##############################


COPY srcs/init.sh /

EXPOSE 3306

ENTRYPOINT ["/init.sh"]