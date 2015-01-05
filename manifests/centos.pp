node 'dbbase' {
yumrepo { "Percona" :
  name    	=> "Percona",
  descr		=> "Percona Server",
  baseurl	=> "http://repo.percona.com/centos/latest/os/x86_64/",
  enabled 	=> 1,
  gpgcheck      => 0,
} ->
 
yumrepo { "Percona-tools":
  name          => "Percona-tools",
  descr         => "Percona Tools",
  baseurl       => "http://repo.percona.com/centos/latest/os/noarch",
  enabled       => 1,
  gpgcheck      => 0,
} ->

package { 'Percona-XtraDB-Cluster-server-55': 
  require  =>  Yumrepo["Percona"],
  ensure   => latest,
} ->

# class { 'mysql::server': 
#  require 	   => [ Yumrepo["Percona"], File['/etc/init.d/mysqld'] ],
#  server_package_name     => 'Percona-Server-server-55',
#  package_ensure   => latest,
#  service_name     => 'mysql',
#  config_hash      => {
#    'pidfile'      => '/var/lib/mysql/localhost.localdomain.pid',
#    'bind_address' => '0.0.0.0',
#  },
# } ->

file { '/etc/init.d/mysqld' :
   ensure => 'link',
   target => '/etc/init.d/mysql',
} -> 

file { '/var/log/mysql' :
   ensure => 'directory',
   mode   => '0755',
   owner  => 'mysql',
   group  => 'mysql',
} -> 

}

file { '/etc/my.cnf' :
   mode   => '0644',
   owner  => 'mysql',
   group  => 'mysql',
   source => "puppet:///files/mysqldb02.my.cnf",
} ->


$packagelist = ["joe", "perl", "rubygems", "nano", "mlocate"]

package { $packagelist :
  ensure => installed }
}
