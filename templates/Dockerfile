FROM gitinsky/apache2-php5:0.1.4
MAINTAINER Git In Sky <support@gitinsky.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    bash -c "unset TERM && apt-get -y install curl less wget unzip apt-transport-https ca-certificates software-properties-common language-pack-en localepurge" && \
    wget --quiet -O - http://packages.icinga.org/icinga.key | apt-key add - && \
    echo "deb http://packages.icinga.org/ubuntu icinga-trusty main" >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe" >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get -y install php5-cli php5-common php5-cgi php5-curl php5-imagick php5-imap php5-pgsql php5-sqlite php5-mysql php5-fpm php5-mcrypt php5-ldap php5-json php5-intl php5-gd && \
    apt-get -y install icinga2 icinga2-ido-mysql nagios-plugins icingaweb2 icinga2-classicui && \
    apt-get -y install nagios-nrpe-plugin --no-install-recommends && \
    echo 'date.timezone = "Europe/Moscow"' >> /etc/php5/apache2/php.ini && \
    usermod -a -G nagios www-data && \
    mkdir /var/lib/php5-sessions && \
    mkdir /etc/icingaweb2/enabledModules && \
    chown www-data:icingaweb2 /etc/icingaweb2/enabledModules && \
    chmod 2750 /etc/icingaweb2/enabledModules && \
    ln -s /usr/share/icingaweb2/modules/monitoring /etc/icingaweb2/enabledModules/monitoring
ADD icinga2-ido-mysql.conf /etc/dbconfig-common/icinga2-ido-mysql.conf
ADD ido-mysql.conf /etc/icinga2/features-enabled/ido-mysql.conf
ADD icinga2.rb /etc/eye/icinga2.rb
ADD createdb.sh /root/createdb.sh
ADD php.ini /etc/php5/apache2/php.ini
ADD hosts.conf /etc/icinga2/conf.d/hosts.conf
ADD icingaweb2 /etc/icingaweb2/
RUN mkdir -p /run/icinga2/cmd && \
    chown -R nagios:nagios /run/icinga2 && \
    icinga2 feature enable ido-mysql statusdata compatlog && \
    icinga2 feature enable command && \
    icingacli setup config directory --group icingaweb2
EXPOSE 80
