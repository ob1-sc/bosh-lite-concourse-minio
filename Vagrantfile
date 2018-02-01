# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # bosh-lite VM
  config.vm.define "bosh-lite" do |bl|

    bl.vm.box = 'cloudfoundry/bosh-lite'
    bl.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=777"] # ensure any VM user can create files in subfolders - eg, /vagrant/tmp
    bl.vm.provider :virtualbox do |v, override|
      v.memory = 12288
      v.cpus = 4
      override.vm.box_version = '9000.137.0' # ci:replace
      # To use a different IP address for the bosh-lite director, uncomment this line:
      # override.vm.network :private_network, ip: '192.168.59.4', id: :local
    end

  end

  # ubuntu client VM
  config.vm.define "cli-vm" do |clivm|

    clivm.vm.box = "ubuntu/xenial64"
    clivm.vm.provider :virtualbox do |v, override|
      v.memory = 4096
      v.cpus = 1
    end

    clivm.vm.provision "shell", privileged: true, path: "yaml-patch-install.sh"
    clivm.vm.provision "shell", privileged: true, path: "bosh-cli-install.sh"
    clivm.vm.provision "shell", privileged: false, path: "bosh-lite-settings.sh"
    clivm.vm.provision "shell", privileged: false, path: "concourse-install.sh"
    clivm.vm.provision "shell", privileged: true, path: "fly-install.sh"

  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
