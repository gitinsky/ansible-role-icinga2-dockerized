mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} < /usr/share/icinga2-ido-mysql/schema/mysql.sql
mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} < /usr/share/icingaweb2/etc/schema/mysql.schema.sql
{% for user in icinga2.web.users %}
mysql -u {{ icinga2.ido.user }} -h {{ icinga2.ido.dbserver }} -p{{ icinga2.ido.pass }} {{ icinga2.ido.dbname }} -e 'INSERT INTO icingaweb_user (name, active, password_hash) VALUES ("{{ user.name }}", 1, "{{ user.pass_hash }}");'
{% endfor %}
