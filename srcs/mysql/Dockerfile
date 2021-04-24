# FROM alpine:3.12

# RUN apk add --update mysql mysql-client --no-cache \
# && rm -f /var/cache/apk/*

# ########### mysql ############

# RUN mkdir -p /var/run/mysqld
# COPY srcs/my.cnf /etc/my.cnf

# ##############################


# COPY srcs/init.sh /

# EXPOSE 3306

# ENTRYPOINT ["/init.sh"]


FROM alpine:3.12

# ENV TELEGRAF_VERSION=1.17.0 \
#     TELEGRAF_HOSTNAME=mysql

RUN mkdir -p /var/run/mysqld && \
    apk add --no-cache mysql mysql-client

COPY srcs/my.cnf /etc/my.cnf
COPY srcs/init.sh /
# COPY srcs/healthcheck.sh /
# COPY srcs/create_tables.sql /tmp/create_phpmyadmin_tables.sql

RUN chmod +x /init.sh

EXPOSE 3306

VOLUME [ "/var/lib/mysql" ]

CMD [ "/start.sh" ]
