# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "minion" do |minion|
    minion.vm.box = "trusty"
    minion.vm.host_name = "minion"
    minion.vm.network :private_network, ip: "192.168.56.103"
    minion.vm.network "public_network", :bridge => 'eth0'
    minion.vm.synced_folder "./salt/roots/", "/srv/salt/"
    minion.vm.provision :salt do |salt|
      salt.run_highstate = true
      salt.minion_config = "./minion.conf"
      salt.minion_key = "./minion.pem"
      salt.minion_pub = "./minion.pub"
    end

    #minion.vm.network "forwarded_port", guest: 80, host: 8080
  end
end
