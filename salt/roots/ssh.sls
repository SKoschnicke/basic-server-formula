{# ssh to access the server #}
openssh-server:
  pkg.installed

ssh:
  service:
    - running
    - watch:
      - file: /etc/ssh/sshd_config
    - require:
        - pkg: openssh-server

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sshd.config
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        allowed_users: {{ users }}
