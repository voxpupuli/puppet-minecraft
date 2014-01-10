class minecraft::settings {

  define settings {
    file { $title :
      ensure  => file,
      path    => "${minecraft::install_dir}/${title}",
      content => template("minecraft/${title}.erb"),
      owner   => $minecraft::user,
      group   => $minecraft::group,
      mode    => '0664',
      require => User[$minecraft::user],
    }
  }

  settings { 'server.properties': }

  if $minecraft::ops != [] {
    settings {'ops.txt': }
  }

  if $minecraft::banned_players != [] {
    settings {'banned-players.txt': }
  }

  if $minecraft::banned_ips != [] {
    settings {'banned-ips.txt': }
  }

  if $minecraft::white_list_players != [] {
    settings {'white-list.txt': }
  }
}
