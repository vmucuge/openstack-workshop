node 'repo.test.vm' {

  yumrepo { 'epel' :
    descr    => 'Extra Packages for Enterprise Linux 6 - $basearch',
    baseurl  => 'http://mirror.uv.es/mirror/fedora-epel/6/x86_64/',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'http://mirror.uv.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
  } ->

  yumrepo { 'rabbitmq' :
    descr    => 'Rabbitmq-Server Local',
    baseurl  => 'http://192.168.33.33/rabbitmq/',
    enabled  => '0',
    gpgcheck => '0',
  } ->

  yumrepo { 'epel-erlang' :
    descr    => 'Erlang/OTP R14B',
    baseurl  => 'http://packages.erlang-solutions.com/rpm/centos/6/$basearch/',
    enabled  => '1',
    gpgcheck => '0',
  } ->

  exec { 'yumclean':
    path    => "/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/bin",
    command => "yum clean all",
  } ->

  package { 'git':
    ensure  => 'latest'
  } ->

  package { 'nano':
    ensure  => 'latest',
  } ->

  package { 'yum-utils' :
    ensure  => 'installed',
  } ->

  package { 'repoview' :
    ensure  => 'latest',
  }

} 
