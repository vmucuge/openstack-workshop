node 'dbbase' {
  
  yumrepo { 'Percona' :
    name    	  => "percona",
    descr		  => "Percona Server",
    baseurl	      => "http://repo.percona.com/centos/latest/os/x86_64/",
    enabled 	  => 1,
    gpgcheck      => 0,
  } ->
 
  yumrepo { 'Percona-tools':
    name          => "percona-tools",
    descr         => "Percona Tools",
    baseurl       => "http://repo.percona.com/centos/latest/os/noarch",
    enabled       => 1,
    gpgcheck      => 0,
  } ->
 
  package { 'Percona-XtraDB-Cluster-server-55': 
    require  =>  Yumrepo['Percona'],
    ensure   =>  latest,
  } ->

  file { '/etc/init.d/mysqld' :
    ensure => 'link',
    target => '/etc/init.d/mysql',
    require => Package['Percona-XtraDB-Cluster-server-55'],
  } -> 

  file { '/var/log/mysql' :
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'mysql',
    group   => 'mysql',
    require => Package['Percona-XtraDB-Cluster-server-55'],
  }

  service { 'mysql' :
    ensure  => running,
    enable  => 'true',
    require => Package['Percona-XtraDB-Cluster-server-55'],
  }

}

node 'db01.test.vm' inherits dbbase {
  
  file { '/etc/my.cnf' :
    mode   => '0644',
    owner  => 'mysql',
    group  => 'mysql',
    source => "puppet:///files/mysqldb01.my.cnf",
    require => Package['Percona-XtraDB-Cluster-server-55'],
    notify  => Service['mysql'],
  }

}

node 'db02.test.vm' inherits dbbase {
  
  file { '/etc/my.cnf' :
    mode   => '0644',
    owner  => 'mysql',
    group  => 'mysql',
    source => "puppet:///files/mysqldb02.my.cnf",
    require => Package['Percona-XtraDB-Cluster-server-55'],
    notify  => Service['mysql'],
  }

}

node 'www.test.vm' {
  # Configuring apache
  include apache
  include apache::mod::php
 
  apache::vhost { $::fqdn:
    port => '80',
    docroot => '/var/www/test',
    require => File['/var/www/test'],
  }

  # Setting up the document root
  file { ['/var/www', '/var/www/test'] :
    ensure => directory,
  }

  file { '/var/www/test/index.php' :
    content => '>?php echo \'>p<Hello world!>/p<\' ?<',
  }

}

node 'logstash.test.vm' {

}

node 'elastic01.test.vm' {

  yumrepo { 'elasticsearch':
    descr    => 'elasticsearch repo',
    baseurl  => "http://packages.elasticsearch.org/elasticsearch/1.3/centos",
    gpgcheck => 1,
    gpgkey   => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    enabled  => 1,
  }

  yumrepo { 'epel' :
    descr    => 'Extra Packages for Enterprise Linux 6 - $basearch',
    baseurl  => 'http://mirror.uv.es/mirror/fedora-epel/6/x86_64/',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'http://mirror.uv.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
  }

  package { 'java-1.7.0-openjdk':
    ensure  => 'latest',
  }

  class { 'elasticsearch':
    config                   => {
      'node'                 => {
        'name'               => 'elastic01'
      },
      'index'                => {
        'number_of_replicas' => '0',
        'number_of_shards'   => '3'
      },
      'network'              => {
        'host'               => $::ipaddress
      }
    }
  }

}