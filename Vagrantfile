# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'fog/version'

dir = File.dirname(File.expand_path(__FILE__))
configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile']

Vagrant.require_version '>= 1.6.0'

Vagrant.configure('2') do |config|
  data['hosts'].each do |opts|
    config.vm.define opts do |config|
      config.vm.box = "#{data['box']}"
      config.vm.hostname = opts
      config.vm.network "private_network", ip: "#{data[opts]['ip']}"
      config.ssh.private_key_path = "#{data['auth']['private_key']}"
      config.vm.synced_folder ".", "/vagrant", disabled: true
      data['synced_folder'].each do |i, folder|
        if folder['source'] != '' && folder['target'] != ''
          config.vm.synced_folder "#{folder['source']}", "#{folder['target']}"
        end
      end
      config.vm.provision "shell",
        path: "#{data['provision']['salt']}",
        args: "#{data[opts]['role']} #{opts} #{data[opts]['ip']} #{data['synced_folder']['devops']['target']}"
    end
  end
end
