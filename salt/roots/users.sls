bash:
  pkg.installed

{# for every user configured above, a system user is created #}
{% for username, uid in pillar.get('users', {}).items() %}
# we are creating the home directory separatly because user.present creates the dir with wrong permissions (300 instead of 700)
/home/{{ username }}:
  file.directory:
    - user: {{ username }}
    - group: {{ username }}
    - dir_mode: 700

{{ username }}:
  user.present:
    - uid: {{ uid }}
    - groups:
      - sudo
    - optional_groups:
      - {{ username }}
    - shell: /bin/bash
{# default password "threemonkeys" in hash-form, generated by: 
   python -c "import crypt, getpass, pwd; print crypt.crypt('threemonkeys', '\$6\$sdflkj3r9u3tkdsf\$')"
#}
    - password: "$6$sdflkj3r9u3tkdsf$BpZ7i7XaPftEIVk376d31WzSNvQY/OcE3T5vSWgIIE5ksqXbF26y8I83C3XtWk8XM2nmYNl8aydnM.fLOu90l/"
    - require:
      - pkg: bash
{% endfor %}