class profile::wordpress {
  

  
  ##Mysql server
  
  
  #wordpress config

  
  #setup wordpress
  class {'::wordpress':
    wp_owner => 'wordpress',
    wp_group => 'wordpress',
    
    Require => [
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
