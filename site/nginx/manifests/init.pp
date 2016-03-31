class nginx {
  
  case $::osfamily {
    'redhat','debian' : {
      $service_user = 'nginx'
      $log_directory = '/var/log/nginx'
      $config_directory = '/etc/nginx/'
      $document_root = '/var/www'    
    }
    'windows': {
      $service_user = 'nginx'
      $log_directory = 'C:/ProgramData/nginx/logs'
      $document_root = 'C:/ProgramData/nginx/html'
      $config_directory = 'C:/ProgramData/nginx'
    }
  }

  # $www_path = '/var/www'
  # $etc_nginx_path = '/etc/nginx'
  $modules_nginx_path = '/modules/nginx'
  
  File {
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  package { 'nginx':
    ensure => installed,
  }
  
  file { "${document_root}":
    ensure  => directory,
  }
  
  file { "${document_root}/index.html":
    ensure  => file,
    source => "puppet://${modules_nginx_path}/index.html",
  }
    
  file { "${config_directory}/nginx.conf":
    ensure  => file,
    content  => template('nginx/default.conf.erg'),

  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    # subscribe => File["${config_directory}/nginx.conf"],
  }
}
