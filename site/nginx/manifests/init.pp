class nginx {

  $www_path = '/var/www'
  $etc_nginx_path = '/etc/nginx'
  $modules_nginx_path = '/modules/nginx'
  
  package { 'nginx':
    ensure => installed,
  }
  
  file { "${www_path}":
    ensure  => directory,
  }
  
  file { "${www_path}/index.html":
    ensure  => file,
    source => "puppet://${modules_nginx_path}/index.html",
  }
    
  file { "${etc_nginx_path}/nginx.conf":
    ensure  => file,
    source  => "puppet://${modules_nginx_path}/nginx.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    # subscribe => File["${etc_nginx_path}/nginx.conf"],
  }
}
