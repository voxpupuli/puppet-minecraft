class minecraft::server_prop {

  file { 'server.properties':
    ensure  => file,
    path    => "${::minecraft::homedir}/server.properties",
    owner   => $::minecraft::user,
    group   => $::minecraft::group,
    mode    => '0664',
    content => template('minecraft/server.properties.erb'),
  }
}

