class users::admins {
  users::managed_user { 'jose':
    homedir => '/var/www/muppets/jose',
    sshdir => '/path/to/jose',
  }
  users::managed_user { 'alice':
    homedir => '/var/www/muppets/alice',
    sshdir => '/path/to/alice',
  }
  users::managed_user { 'chen':
    homedir => '/var/www/muppets/chen',
    sshdir => '/path/to/chen',
  }
}
