{% for database in database_list %}
mysql -u {{ database.user }} -h {{ database.host }} -p{{ database.password }} {{ database.name }} < {{ database.dump }}
{% endfor %}
{% for user in icinga2.web.users %}
mysql -u {{ database_list[0].user }} -h {{ database_list[0].host }} -p{{ database_list[0].password }} {{ database_list[0].name }} -e 'INSERT INTO icingaweb_user (name, active, password_hash) VALUES ("{{ user.name }}", 1, "{{ user.pass_hash }}");'
{% endfor %}
