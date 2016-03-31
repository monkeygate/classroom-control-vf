class nginx::params {
  case $::osfamily {
    'redhat', 'debian': {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $docroot = '/var/www'
    }
    'windows': {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
      $docroot = 'C:/ProgramData/nginx/html'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
    $user = $::osfamily ? {
      'redhat'  => 'nginx',
      'debian'  => 'www-data',
      'windows' => 'nobody',
    }    
  }
}
