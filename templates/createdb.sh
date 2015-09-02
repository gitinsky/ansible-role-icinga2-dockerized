{% for database in database_list %}
mysql -u {{ database.user }} -h {{ database.host }} -p{{ database.password }} {{ database.name }}< {{ database.dump }}
{% endfor %}
