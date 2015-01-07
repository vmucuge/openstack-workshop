# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "Centos64"

  config.vm.synced_folder "./files", "/etc/puppet/files"
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.define :repo do |repo|
    vm_name = "repo"
    config.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "256", "--name", "#{vm_name}"]
    end
    repo.vm.hostname = "repo.test.vm"
    repo.vm.network :private_network, ip: "192.168.56.33"
    repo.vm.network :private_network, ip: "192.168.33.33"
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "repo.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/fileserver.conf"
    end
    repo.vm.provision "shell", path: "installrepo.sh"
  end


  config.vm.define :compute01 do |compute01|
    vm_name = "rdo-compute01"
    config.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]
    end
    compute01.vm.hostname = "rdo-compute01.test.vm"
    compute01.vm.network :private_network, ip: "192.168.56.21"
    compute01.vm.network :private_network, ip: "192.168.33.21"
    compute01.vm.provision "shell", path: "deploy.sh"
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "rdo-compute01.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/fileserver.conf"
    end

  end

  config.vm.define :network01 do |network01|
    vm_name = "rdo-network01"
    config.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]
    end
    network01.vm.hostname = "rdo-network01.test.vm"
    network01.vm.network :private_network, ip: "192.168.56.22"
    network01.vm.network :private_network, ip: "192.168.33.22"
    network01.vm.provision "shell", path: "deploy.sh"

    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "rdo-network01.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/fileserver.conf"
    end
    end

  config.vm.define :controller01 do |controller01|
    cinder_volume = "/tmp/cinder_volume.vdi"
    vm_name = "rdo-controller01"

    config.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024", "--name", "#{vm_name}"]
      unless File.exist?(cinder_volume)
        vb.customize ['createhd', '--filename', cinder_volume, '--size', 20 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', cinder_volume]
    end

    controller01.vm.hostname = "rdo-controller01.test.vm"
    controller01.vm.network :forwarded_port, guest: 80, host: 8080
    controller01.vm.network :forwarded_port, guest: 5000, host: 5000
    controller01.vm.network :private_network, ip: "192.168.56.20"
    controller01.vm.network :private_network, ip: "192.168.33.20"

    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "rdo-controller01.pp"
      puppet.module_path    = "modules"
      puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/fileserver.conf"
    end
    controller01.vm.provision "shell", path: "bootstrap.sh"

  end

end

#If YOU WANT TO RUN GLOBALLY

#config.vm.provision :shell, :path => "bootstrap1.sh"
#config.vm.provision :shell, :path => "bootstrap2.sh"
#config.vm.provision :shell, :path => "elasticrepo.sh"
#host01.vm.provision :puppet, manifests_path => "manifests", manifest_file => "host01.pp"

#config.vm.provision :puppet do |puppet|
#  puppet.manifests_path = "manifests"
#  puppet.manifest_file  = "rdo-node01.pp"
#  puppet.module_path    = "modules"
#  puppet.options        = "--verbose --debug --fileserverconfig=/vagrant/fileserver.conf"
#end

#config.vm.provision "shell" do |sh|
#  sh.path = "bootstrap.sh"
#end
