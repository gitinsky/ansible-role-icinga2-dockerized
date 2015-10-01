chown nagios /var/cache/icinga2
chown nagios /var/log/icinga2
mkdir /run/icinga2/cmd
chown -R nagios /run/icinga2
chown -R nagios /var/lib/icinga2
mysqlshow -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} | grep icinga_acknowledgements
if [ $? != 0 ]; then
  date
  echo "Loading /usr/share/icinga2-ido-mysql/schema/mysql.sql"
  mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} < /usr/share/icinga2-ido-mysql/schema/mysql.sql
  echo "...loaded"
fi
mysqlshow -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} | grep icingaweb_group
if [ $? != 0 ]; then
  date
  echo "Loading /usr/share/icingaweb2/etc/schema/mysql.schema.sql"
  mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} < /usr/share/icingaweb2/etc/schema/mysql.schema.sql
  echo "....loaded"
fi
{% for user in icinga2.web.users %}
mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} -e 'INSERT INTO icingaweb_user (name, active, password_hash) VALUES ("{{ user.name }}", 1, "{{ user.pass_hash }}");'
{% endfor %}
