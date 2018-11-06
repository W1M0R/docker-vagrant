# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

yml = YAML.load_file 'vagrant.yml'
share_path = yml['settings']['share_path']

post_up_message = <<-EOT
Welcome

Vagrant is insecure by default:
https://stackoverflow.com/questions/14715678/vagrant-insecure-by-default
https://stackoverflow.com/questions/30432408/why-can-user-vagrant-do-sudo-su-without-entering-password

Run the following commands in your box to make it more secure:
1. Change your root password from vagrant to something else, e.g. sudo passwd.
2. Change your user password from vagrant to something else, e.g. passwd.
3. View your unwrapped secrets passphrase (default password is vagrant), e.g. ecryptfs-unwrap-passphrase ~/.ecryptfs/wrapped-passphrase.
4. Wrap your secrets passphrase with your new user password, e.g. ecryptfs-rewrap-passphrase ~/.ecryptfs/wrapped-passphrase.
5. Your encrypted secrets folder is ~/.secrets.
6. Investigate the pros and cons of removing passwordless sudo rights from your user.
EOT

Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-18.04"
    config.vm.provider "virtualbox" do |v|
        v.memory = 2046
        v.cpus = 3
    end
    config.vm.provision "docker"
    config.vm.provision "secure-docker-user", type: "shell", inline: "/bin/bash /vagrant/scripts/secure-docker-user.sh", privileged: false
    config.vm.provision "install-docker-compose", type: "shell", inline: "/bin/bash /vagrant/scripts/install-docker-compose.sh", privileged: false
    config.vm.provision "install-docker-machine", type: "shell", inline: "/bin/bash /vagrant/scripts/install-docker-machine.sh", privileged: false
    config.vm.provision "install-encryption-tools", type: "shell", inline: "/bin/bash /vagrant/scripts/install-encryption-tools.sh", privileged: false
    config.vm.provision "install-encrypted-secrets", type: "shell", inline: "/bin/bash /vagrant/scripts/install-encrypted-secrets.sh", privileged: false
    config.vm.provision "echo-machine-info", run: "always", type: "shell", inline: "/bin/bash /vagrant/scripts/echo-machine-info.sh", privileged: false
    config.vm.synced_folder share_path, "/home/vagrant/shared"
    config.vm.network "public_network"
    config.vm.post_up_message = post_up_message
end
