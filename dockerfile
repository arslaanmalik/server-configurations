FROM ubuntu:18.04

ENV TZ=Asia/Karachi
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update && \
       apt-get install -y --no-install-recommends apt-utils

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get install -y tzdata
RUN apt-get install -y software-properties-common && \
add-apt-repository ppa:ondrej/php && \
add-apt-repository -y -u ppa:certbot/certbot
RUN apt-get install -y certbot \
                curl \
                vim \
                nginx \
                composer \
                nginx
RUN apt-get update

#INSTALL PHP
RUN apt-get install -y php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-xml php7.4-mbstring php7.4-soap php7.4-zip

#INSTALL MYSQL
#FROM mysql:8

RUN apt-get install -y mysql-server
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=docker
ENV MYSQL_USER=malik
ENV MYSQL_PASSWORD=password


#INSTALL Postgres
# Add PostgreSQL's repository. It contains the most recent stable release
#  of PostgreSQL.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get install -y postgresql
ENV POSTGRES_PASSWORD=password

#Create a Laravel app
# RUN composer create-project --prefer-dist laravel/laravel blog

#nginx file copy
COPY default2 /etc/nginx/sites-available
#Symbolic Linking
RUN  ln -s /etc/nginx/sites-available/default2 /etc/nginx/sites-enabled/default2



