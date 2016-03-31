class profile::wordpress {

  ##apache
  class { 'apache':
    default_vhost => false,
  }
  
  ##Mysql server
  class { '::mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
  }
  
  #wordpress config
  
  package {'wget':
    ensure => present,
  }
  
  #setup wordpress
  class {'::wordpress':
    wp_owner => 'wordpress',
    wp_group => 'wordpress',
    wp_proxy_host => 'http://proxy-us.intel.com',
    wp_proxy_port => '911',
    db_user        => 'wordpress',
    db_password    => 'strongpassword2',    
    install_dir => '/var/www/wordpress',
    require => [
      Package['wget'],
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
