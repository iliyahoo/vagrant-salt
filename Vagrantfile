# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
#require 'fog/version'

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

dir = File.dirname(File.expand_path(__FILE__))
configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile']

Vagrant.require_version '>= 1.6.0'

Vagrant.configure('2') do |config|
  data['hosts'].each do |opts|
    hostname = opts[0]
    params = opts[1]
    config.vm.define hostname do |config|
      config.vm.box = params['box'].nil? ? data['box'] : params['box']
      config.vm.hostname = hostname
      config.vm.network "private_network", ip: "#{params['ip']}"
#      config.vm.network "public_network", bridge: "#{data['interface']}: Wi-Fi (AirPort)"
#      config.ssh.private_key_path = "#{data['auth']['private_key']}"
      config.vm.synced_folder ".", "/vagrant", disabled: true
      data['synced_folder'].each do |i, folder|
        if folder['source'] != '' && folder['target'] != ''
          config.vm.synced_folder "#{folder['source']}", "#{folder['target']}"
        end
      end
      config.vm.provider "virtualbox" do |v|
        v.memory = "#{params['memory']}"
        v.cpus = 2
      end
      config.vm.provision "shell",
        path: "#{data['provision']['init']}"
#        path: "#{data['provision']['salt']}",
#        args: "#{params['role']} #{opts} #{data['master']['ip']} #{data['synced_folder']['devops']['target']} #{data['provision']['version']} #{data['provision']['repo']}"
    end
  end
end
