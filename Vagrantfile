# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'fog/version'

dir = File.dirname(File.expand_path(__FILE__))
configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile-gce']

Vagrant.require_version '>= 1.6.0'

Vagrant.configure('2') do |config|
  data['vm']['hosts'].each do |opts|
    config.vm.define opts do |config|
      config.vm.box = "#{data['vm']['box']}"
      config.vm.hostname = opts
      config.vm.network "private_network", ip: "#{data['vm']['instance'][opts]['ip']}"
      config.ssh.private_key_path = "#{data['vm']['auth']['private_key']}"
      config.vm.synced_folder ".", "/vagrant", disabled: true
      data['vm']['synced_folder'].each do |i, folder|
        if folder['source'] != '' && folder['target'] != ''
          config.vm.synced_folder "#{folder['source']}", "#{folder['target']}"
        end
      end
      config.vm.provision "shell", path: "#{data['vm']['provision']['salt']}", args: "#{data['vm']['instance'][opts]['role']} #{opts} #{data['vm']['instance']['master']['ip']} #{data['vm']['synced_folder']['devops']['target']}"
    end
  end
end
