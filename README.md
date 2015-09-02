You should define following variables to start icinga2

<pre>
icinga2:
  ido:
    user: icinga2
    pass: rocOrfyad
    dbserver: mysql
    dbname: icinga2
  web:
    users:
    - { name: foo, pass_hash: $1$6jLt.cwU$MFYw44n3A6pFUmeKNBL9W0}
    - { name: bar, pass_hash: $1$6jLt.cwU$MFYw44n3A6pFUmeKNBL9W0}
    admins:
      - foo
      - bar
</pre>

Generate password with `openssl passwd -1 'password'`