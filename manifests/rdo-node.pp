node 'rdo-base' {

  yumrepo { 'epel-erlang' :
    descr    => 'Erlang/OTP R14B',
    baseurl  => 'https://repos.fedorapeople.org/repos/peter/erlang/epel-5Server/x86_64/',
    enabled  => '1',
    gpgcheck => '1'
  } ->

  #yumrepo { 'splunk' :
  #  descr     => "Splunk Repo Local",
  #  baseurl   => "http://192.168.33.1/rpms/splunk/",
  #  gpgcheck  => '0',
  #  enabled   => '1',
  #} ->

  package { 'vim-enhanced' :
    ensure  => 'latest'
  } ->

  package { 'nano' :
    ensure  => 'latest'
  } ->

  package { 'java-1.7.0-openjdk' :
    ensure  => 'latest',
  }

  #host { 'splunkserver.test.vgm':
  #      ip => '192.168.33.200',
  #      host_aliases => [ 'splunkserver' ],
  #}

}

node 'rdo-node01.test.vm'  inherits rdo-base {

  host { 'rdo-node01.test.vgm':
    ip => '192.168.33.20',
    host_aliases => [ 'rdo-node01' ],
  } ->

  host { 'rdo-node02.test.vgm':
    ip => '192.168.33.21',
    host_aliases => [ 'rdo-node02' ],
  } ->

  host { 'repo.test.vgm':
    ip => '192.168.33.1',
    host_aliases => [ 'pc-repo' , 'pc-repo.local' , 'repo' ],
  } ->

  host { 'splunkserver.test.vgm':
    ip => '192.168.33.200',
    host_aliases => [ 'splunkserver' ],
  } ->

  package { 'openstack-packstack' :
  	ensure  => 'latest'
  }

  #class { 'splunk' :
  #  install        => 'forwarder',
  #  forward_server => [ "splunkserver.test.vgm:9997", ],
  #  admin_password => "admin",
  #  monitor_path   => [ "/var/log/messages" , "/var/log/nova/*.log" , "/var/log/dmesg" , "/var/log/lastlog" , "/var/log/secure" , "/var/log/openvswitch/*.log" , "/var/log/libvirt/*.log" , "/var/log/libvirt/qemu/*.log" , "/var/log/ceilometer/*.log" , "/var/log/cinder/*.log" , "/var/log/glance/*.log" , "/var/log/heat/*.log" , "/var/log/nagios/*.log" , "/var/log/horizon/*.log" , "/var/log/keystone/*.log" , "/var/log/httpd/*.log" ],
  #}

}

node 'rdo-node02.test.vm'  inherits rdo-base {

  host { 'rdo-node01.test.vgm':
    ip => '192.168.33.20',
    host_aliases => [ 'rdo-node01' ],
  } ->

  host { 'rdo-node02.test.vgm':
    ip => '192.168.33.21',
    host_aliases => [ 'rdo-node02' ],
  } ->

  host { 'repo.test.vgm':
    ip => '192.168.33.1',
    host_aliases => [ 'pc-repo' , 'pc-repo.local' , 'repo' ],
  } ->

  host { 'splunkserver.test.vgm':
    ip => '192.168.33.200',
    host_aliases => [ 'splunkserver' ],
  }

  #class { 'splunk' :
  #  install        => 'forwarder',
  #  forward_server => [ "splunkserver.test.vgm:9997", ],
  #  admin_password => "admin",
  #  monitor_path   => [ "/var/log/messages" , "/var/log/nova/*.log" , "/var/log/dmesg" , "/var/log/lastlog" , "/var/log/secure" , "/var/log/openvswitch/*.log" , "/var/log/libvirt/*.log" , "/var/log/libvirt/qemu/*.log" , "/var/log/ceilometer/*.log" ],
  #}

}