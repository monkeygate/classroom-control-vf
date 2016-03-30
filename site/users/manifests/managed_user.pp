define users::managed_user (
    $user = $title,
    $homedir     = '/var/log/httpd',
    $sshdir     = '/var/ssh',
 ){
  user { "${title}":
    ensure  => user,
    homedir   => $homedir,
    sshdir   => $sshdir,
  }
}
