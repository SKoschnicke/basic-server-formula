{# disable IPV6 because it is not used and causes only trouble when enabled but unused #}
net.ipv6.conf.all.disable_ipv6:
  sysctl.present:
    - value: 1
