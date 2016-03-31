class nginx(
  $root      = '/var/www',
  $package    = $nginx::params::package,
  $owner   = $nginx::params::owner,
  $group     = $nginx::params::group,
  $docroot     = $nginx::params::docroot,
  $confdir    = $nginx::params::confdir,
  $logdir = $nginx::params::logdir,
) inherits nginx::params {

  ##  Because Redhat and Debian are different here, we can't specify the user of
  ## of the nginx service in the big case statement above. Thus we have the
  ## selector here...
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  File {
    owner => $owner,
    group => $group,
    mode  => '0644',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  package { 'nginx':
    ensure => installed,
    name   => $package,
  }
  
  file { "${confdir}/nginx.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
  }
  
  file { "/etc/nginx/conf.d/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { '${docroot}':
    ensure => directory,
  }  
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
