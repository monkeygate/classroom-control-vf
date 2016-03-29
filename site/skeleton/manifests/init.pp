file { '/etc/ssh/sshd_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/ssh/sshd_config',
  }
