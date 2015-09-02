FROM gitinsky/apache2-php5:0.1.2
MAINTAINER Git In Sky <support@gitinsky.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    bash -c "unset TERM && apt-get -y install curl less wget unzip apt-transport-https ca-certificates software-properties-common language-pack-en localepurge"
RUN wget --quiet -O - http://packages.icinga.org/icinga.key | apt-key add - && \
    echo "deb http://packages.icinga.org/ubuntu icinga-trusty main" >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get -y install php5-cli php5-common php5-cgi php5-curl php5-imagick php5-imap php5-pgsql php5-sqlite php5-mysql php5-fpm php5-mcrypt php5-ldap php5-json php5-intl php5-gd && \
    apt-get -y install icinga2 icinga2-ido-mysql nagios-plugins icingaweb2 && \
    apt-get -y install nagios-nrpe-plugin --no-install-recommends
RUN echo 'date.timezone = "Europe/Moscow"' >> /etc/php5/apache2/php.ini
ADD icinga2-ido-mysql.conf /etc/dbconfig-common/icinga2-ido-mysql.conf
ADD ido-mysql.conf /etc/icinga2/features-enabled/ido-mysql.conf
ADD icinga2.rb /etc/eye/icinga2.rb
ADD createdb.sh /root/createdb.sh
RUN mkdir -p /run/icinga2/cmd && \
    chown -R nagios:nagios /run/icinga2/cmd && \
    icinga2 feature enable ido-mysql && \
    icinga2 feature enable command && \
    icingacli setup config directory --group icingaweb2 && \
    icingacli setup token create
EXPOSE 80
