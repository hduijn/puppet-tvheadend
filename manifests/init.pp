# == Class: tvheadend
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
class tvheadend(
  $tvheadendrepo     = 'https://github.com/tvheadend/tvheadend.git',
  $tvheadendrepotype = 'git',
  $oscamrepo         = 'http://www.streamboard.tv/svn/oscam/trunk',
  $oscamrepotype     = 'svn',
  $packages          = ['build-essential','autoconf','git','subversion','pkg-config','libssl-dev','bzip2','wget','dialog'],
  $htsdirs           = ['/home/hts','/home/hts/.hts','/home/hts/.hts/tvheadend','/home/hts/.hts/tvheadend/caclient'],
  $oscamdirs         = ['/opt/oscam','/opt/oscam/etc','/opt/oscam/etc/cw']
)
{
  package { $packages:
    ensure      => installed
  }

  user { "hts":
        ensure     => present,
        groups     => ["video"],
  }
 
  file { $htsdirs:
    ensure      => directory,
    owner       => 'hts',
    mode        => 700,
    require     => User['hts'],
  }

  vcsrepo { "/opt/tvheadend":
    ensure      => present,
    provider    => $tvheadendrepotype,
    source      => $tvheadendrepo,
    require     => [Package[$packages]]
  }

  vcsrepo { "/opt/oscamsource":
    ensure      => present,
    provider    => $oscamrepotype,
    source      => $oscamrepo,
    require     => [Package[$packages]]
  }

  exec { 'configure_and_make_tvheadend':
    command     => '/opt/tvheadend/configure && /usr/bin/make && /usr/bin/make install',
    cwd         => "/opt/tvheadend",
    path        => ["/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/"],
    unless      => "/usr/bin/test -f /usr/local/bin/tvheadend",
    require     => Vcsrepo["/opt/tvheadend"]
  }

  file { "tvheadend default":
    path    => "/etc/default/tvheadend",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tvheadend/tvheadend-default.erb'),
  }
  file { "tvheadend init":
    path    => "/etc/init.d/tvheadend",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('tvheadend/tvheadend-init.erb'),
  }

  file { 'htssuperuser' :
    path        => "/home/hts/.hts/tvheadend/superuser",
    owner       => 'hts',
    mode        => 700,
    content     => template('tvheadend/superuser.erb'),
  }

  file { 'htscaclient' :
    path        => "/home/hts/.hts/tvheadend/caclient/7e865ff67893f11813a1ee7966f3bede",
    owner       => 'hts',
    mode        => 700,
    content     => template('tvheadend/caclient.erb'),
  }

  service { 'tvheadend' :
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,  
    require     => [File['tvheadend init'],Exec['configure_and_make_tvheadend'],File[$htsdirs]]
  }

  file { $oscamdirs:
    ensure      => directory,
    owner       => 'root',
    mode        => 700,
  }


  file { "oscam conf":
    path    => "/opt/oscam/etc/oscam.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tvheadend/oscam.conf.erb'),
    require => File[$oscamdirs]
  }

  file { "oscam user":
    path    => "/opt/oscam/etc/oscam.user",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tvheadend/oscam.user.erb'),
    require => File[$oscamdirs]
  }

  file { "oscam server":
    path    => "/opt/oscam/etc/oscam.server",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tvheadend/oscam.server.erb'),
    require => File[$oscamdirs]
  }

  file { "oscam binary":
    path    => "/opt/oscam/oscam.bin",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/tvheadend/oscam.bin',
    require => File[$oscamdirs]
  }

  file { "oscam init":
    path    => "/etc/init.d/oscam",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('tvheadend/oscam.erb'),
  }

  service { 'oscam' :
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    require     => [File['oscam init'],File['oscam binary'],File['oscam conf'],File['oscam user'],File['oscam server']]
  }


}
