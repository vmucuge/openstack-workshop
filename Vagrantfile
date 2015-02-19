# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #config.vm.box = "Centos64"
  config.vm.box = "puphpet/centos65-x64"
  config.vm.synced_folder "./files", "/etc/puppet/files"
  config.ssh.pty = "true"
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "512"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  config.vm.define :rdonode01 do |rdonode01|

    vm_name = "rdo-node01"
    cinder_volume = "/tmp/cinder_volume.vdi"

    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]
      vb.customize [ "modifyvm", :id, "--cpus", "2", "--name", "#{vm_name}"]
      vb.customize [ "modifyvm", :id, "--ioapic", "on", "--name", "#{vm_name}"]
      unless File.exist?(cinder_volume)
        vb.customize ['createhd', '--filename', cinder_volume, '--size', 20 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', cinder_volume]
    end

    rdonode01.vm.hostname = "rdo-node01.test.vm"
    rdonode01.vm.network :private_network, ip: "192.168.33.20"
    rdonode01.vm.provision :shell, :path => "files/vg.sh"
    rdonode01.vm.provision :shell, :path => "files/bootstrap.sh"
    rdonode01.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "rdo-node.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/files/fileserver.conf"
    end

  end

  config.vm.define :rdonode02 do |rdonode02|

    vm_name = "rdo-node02"

    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]
      vb.customize [ "modifyvm", :id, "--cpus", "2", "--name", "#{vm_name}"]
      vb.customize [ "modifyvm", :id, "--ioapic", "on", "--name", "#{vm_name}"]
    end

    rdonode02.vm.hostname = "rdo-node02.test.vm"
    rdonode02.vm.network :private_network, ip: "192.168.33.21"
    rdonode02.vm.provision :shell, :path => "files/bootstrap.sh"

    rdonode02.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "rdo-node.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/files/fileserver.conf"
    end

  end

end