class profile::wordpress {
  
  ##Mysql server
  class { '::mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
  }
  
  #wordpress config
  
  #setup wordpress
  class {'::wordpress':
    wp_owner => 'wordpress',
    wp_group => 'wordpress',
    db_user        => 'wordpress',
    db_password    => 'strongpassword2',    
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
