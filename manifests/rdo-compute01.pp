node 'rdo-compute01.test.vm' {

  yumrepo { 'epel' :
    descr    => 'Extra Packages for Enterprise Linux 6 - $basearch',
    baseurl  => 'http://mirror.uv.es/mirror/fedora-epel/6/x86_64/',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'http://mirror.uv.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
  } ->

  yumrepo { 'openstack-icehouse' :
    descr    => 'OpenStack Icehouse Repository',
    #baseurl  => 'http://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/',
    baseurl  => 'http://192.168.33.33/openstack-icehouse/',
    enabled  => '1',
    gpgcheck => '0',
    #gpgkey   => 'http://mirror.uv.es/mirror/fedora-epel/RPM-GPG-KEY-EPEL-6',
  } ->

  yumrepo { 'epel-erlang' :
    descr    => 'Erlang/OTP R14B',
    baseurl  => 'http://packages.erlang-solutions.com/rpm/centos/6/$basearch/',
    enabled  => '1',
    gpgcheck => '0',
  } ->

  package { 'git':
    ensure  => 'latest'
  } ->

  package { 'nano':
    ensure  => 'latest',
  } ->

  package { 'openstack-packstack':
    ensure  => 'latest'
  }

  package { 'java-1.7.0-openjdk':
    ensure  => 'latest',
  }

}
