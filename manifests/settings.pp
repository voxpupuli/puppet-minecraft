class minecraft::settings {

  $files = [ 'server.properties', 'ops.txt', 'banned-players.txt',
             'banned-ips.txt', 'white-list.txt' ]

  define settings {
    file { $title :
      ensure  => file,
      path    => "${install_dir}/${title}",
      content => template("minecraft/${title}.erb"),
      owner   => $user,
      group   => $group,
      mode    => '0664',
    }
  }

  settings { $files: }

}
