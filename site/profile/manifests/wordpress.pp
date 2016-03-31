class profile::wordpress {
  

  
  ##Mysql server
  
  
  #wordpress config

  
  #setup wordpress
  class {'::wordpress':
    wp_owner => 'wordpress',
    wp_group => 'wordpress',
    install_dir => '/var/www/wordpress',
    require => [
      User['wordpress'],
      Group['wordpress'],
    ]
  }
  #local user
  user { 'wordpress':
    ensure => present,
  }
  
  #local group
  group { 'wordpress':
    ensure => present,
  }
}
