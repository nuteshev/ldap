# -*- mode: ruby -*-
# vi: set ft=ruby :


class FixGuestAdditions < VagrantVbguest::Installers::Linux
    def install(opts=nil, &block)
        communicate.sudo("yum update kernel -y; yum install -y gcc binutils make perl bzip2 kernel-devel kernel-headers", opts, &block)
        super
    end
end

Vagrant.configure("2") do |config|

config.vm.define "ipaserver" do |server|
	config.vm.box = "centos/8.2"
	server.vm.host_name = 'ipaserver'
	server.vm.network "forwarded_port", guest:80, host:8081
	server.vm.network :private_network, ip: "10.0.0.20"
	server.vbguest.installer = FixGuestAdditions
	server.vm.provider "virtualbox" do |vb|
	  vb.memory = 896
	  vb.customize [ "modifyvm", :id, "--natdnshostresolver1", "on"]
	end
	server.vm.provision "shell",
		path: "setup_server.sh"
end

config.vm.define "ipaclient" do |client|
	client.vm.box = "centos/8.2"
	client.vm.host_name = 'ipaclient'
	client.vm.network :private_network, ip: "10.0.0.21"
	client.vbguest.installer = FixGuestAdditions
	client.vm.provider :virtualbox do |vb|
		vb.memory = 512
	    vb.customize [ "modifyvm", :id, "--natdnshostresolver1", "on"]
	end
	client.vm.provision "ansible" do |ansible|
		ansible.playbook = "playbook.yml"
		ansible.become = "true"
	end
end

end