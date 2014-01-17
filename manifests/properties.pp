class minecraft::properties {

  define server_setting {
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

  server_setting { 'server.properties': }

  if $minecraft::ops != undef {
    server_setting { 'ops.txt': }
  }

  if $minecraft::banned_players != undef {
    server_setting { 'banned-players.txt': }
  }

  if $minecraft::banned_ips != undef {
    server_setting { 'banned-ips.txt': }
  }

  if $minecraft::white_list_players != undef {
    server_setting { 'white-list.txt': }
  }
}
