# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
servers = YAML.load_file('servers.yaml')

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Iterate through entries in YAML file
  servers.each do |servers|

    # Comment out lines below to speed up provisioning by disabling
    # installation of Virtualbox guest tools
    config.vbguest.auto_update = false
    config.vbguest.no_install = true

    # Enable SSH forwarding
    config.ssh.forward_agent = true

    # Enable hostmanager (adds entries to /etc/hosts)
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false

    config.vm.define servers["name"] do |srv|

      srv.vm.hostname = servers["name"]
      srv.vm.box = servers["box"]
      srv.vm.network "private_network", ip: servers["ip"]

      servers["forward_ports"].each do |port|
        srv.vm.network :forwarded_port, guest: port["guest"], host: port["host"]
      end

      srv.vm.provider :virtualbox do |v|
        v.cpus = servers["cpu"]
        v.memory = servers["ram"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
      end

      srv.vm.synced_folder "./", "/home/vagrant/#{servers['name']}"

      servers["shell_commands"].each do |sh|
        srv.vm.provision "shell", inline: sh["shell"]
      end

      srv.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = "hiera.yaml"
        puppet.environment_path  = "./environments"
        #puppet.options = ['--verbose --debug']
      end

    end

  end

end
