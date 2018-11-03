# docker-vagrant

A **Docker** virtual machine created and provisioned with **Vagrant**. This repository is primarily aimed at **Microsoft Windows** users that wish to get a **Docker** host up and running quickly and easily.

# Instructions

1. Install [VirtualBox](https://www.virtualbox.org/). A restart may be required.
1. **Optional:** Run **VirtualBox** as *Administrator* then follow the prompts to install the **Oracle VM VirtualBox Extension Pack**. Close **VirtualBox** when done.
1. Install [Vagrant](https://www.vagrantup.com/). A restart may be required.
1. Clone (or [download and extract](https://github.com/W1M0R/docker-vagrant/archive/master.zip)) this repository into *INSERT_YOUR_PATH_HERE*.
1. Open a terminal window and browse to *INSERT_YOUR_PATH_HERE*
1. Run `vagrant up` to start the virtual machine.
1. Run `vagrant ssh` to access a terminal inside the virtual machine.
1. Use **Docker** inside the virtual machine.
1. Run `sudo shutdown now` *inside* the virtual machine or `vagrant halt` *outside* the virtual machine when you are done.
1. Run `vagrant destroy` if you want to create the virtual machine from scratch.
