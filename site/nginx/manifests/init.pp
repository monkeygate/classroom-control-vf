class nginx {
  case $::osfamily {
    'redhat', 'debian': {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'
    }
    default: { fail("OS Family ${::osfamily} is not supported with this nginx module") }
  }

  ## Because Redhat and Debian are different here, we can't specify the user of
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
  
  file { "${confdir}/conf.d/default.conf":
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
