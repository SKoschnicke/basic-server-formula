iptables_packages:
  pkg.installed:
    - pkgs:
      - iptables
      - iptables-persistent

iptables_allow_localhost:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - source: 127.0.0.1
    - save: True

# Allow related/established sessions
iptables_allow_established:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: conntrack
    - ctstate: 'RELATED,ESTABLISHED'
    - save: True

# Set the policy to deny everything unless defined
enable_reject_policy:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
    - require:
      - iptables: iptables_allow_localhost
      - iptables: iptables_allow_established

# allow SSH
iptables_allow_ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: ssh
    - proto: tcp
    - save: True