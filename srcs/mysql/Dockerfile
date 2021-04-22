FROM alpine:3.12

RUN apk update \
&& apk add mysql mysql-client --no-cache

########### mysql ############

RUN mkdir -p /var/run/mysqld

##############################

# COPY srcs/my.cnf /etc/my.cnf
# COPY srcs/start.sh /

# RUN mkdir -p /var/run/mysqld \
#     && apk add --update --no-cache \
#     mysql \
#     mysql-client \
#     && chmod +x /start.sh

# COPY srcs/healthcheck.sh /
# COPY srcs/create_tables.sql /tmp/create_phpmyadmin_tables.sql



COPY srcs/init.sh /

EXPOSE 3306

ENTRYPOINT ["/init.sh"]