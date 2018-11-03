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
    # config.vm.provision "install-system-updates", type: "shell", inline: "/bin/bash /vagrant/scripts/install-system-updates.sh", privileged: false
end
