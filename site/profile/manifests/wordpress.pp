class profile::wordpress {
  

  
  ##Mysql server
  
  
  #wordpress config

  
  #setup wordpress
  class {'::wordpress':
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
