class nginx {
  package { 'nginx':
    ensure => installed,
  }
  
  file { '/var/www':
    ensure  => directory,
  }
  
  file { '/var/www/index.html':
    ensure  => file,
    source => 'puppet:///modules/nginx/index.html',
  }
    
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    # subscribe => File['/etc/nginx/nginx.conf'],
  }
}
