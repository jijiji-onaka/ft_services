FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& mkdir -p /var/run/mysqld \
&& apk add mysql mysql-client telegraf --no-cache

COPY srcs/my.cnf /etc/my.cnf

COPY srcs/init.sh /
RUN chmod +x /init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf
RUN chmod +x /etc/telegraf.conf

COPY srcs/healthcheck.sh /
RUN chmod +x /healthcheck.sh

EXPOSE 3306

VOLUME [ "/var/lib/mysql" ]

CMD [ "/init.sh" ]
