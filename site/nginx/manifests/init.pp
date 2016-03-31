class nginx(
  $root      = '/var/www',
  $package    = $nginx::params::httpd_pkg,
  $owner   = $nginx::params::httpd_user,
  $group     = $nginx::params::httpd_group,
  $docroot     = $nginx::params::httpd_docroot,
  $confdir    = $nginx::params::httpd_confdir,
  $logdir = $nginx::params::httpd_confdir,
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
  
  file { $docroot:
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
