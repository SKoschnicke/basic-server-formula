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
    - source: salt://ssh/files/sshd.config
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        allowed_users: {{ pillar.get('users', {}).keys() }}

{# set ssh keys #}
{% for username, uid in pillar.get('users', {}).items() %}
/home/{{ username }}/.ssh/authorized_keys:
  file.managed:
    - source: salt://ssh/files/ssh-keys/{{ username }}-key.pub
    - user: {{ username }}
    - group: {{ username }}
    - mode: 600
    - makedirs: true
    - dir_mode: 700
    - replace: false
    - require:
      - user: {{ username }}
{% endfor %}