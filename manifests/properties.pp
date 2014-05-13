define minecraft::properties(
  $servername = $title,
  $server_dir,
  ) {

  define server_setting(
    $servername,
    $filename,
    ) {
    
    file { $title :
      ensure  => file,
      path    => "${server_dir}/${filename}",
      content => template("minecraft/${filename}.erb"),
      owner   => Minecraft::Server[${servername}]['user'],
      group   => Minecraft::Server[${servername}]['group'],
      mode    => '0664',
      #explicit user and group requires not needed, puppet will autorequire
    }
  }

  server_setting { "${servername}-server.properties":
    servername => $servername,
    filename => 'server.properties',
  }

  if Minecraft::Server[${servername}]['ops'] != undef {
    server_setting { "${servername}-ops.txt":
      servername => $servername,
      filename => 'ops.txt',      
    }
  }

  if Minecraft::Server[${servername}]['banned_players'] != undef {
    server_setting { "${servername}-banned-players.txt":
      servername => $servername,
      filename => 'banned-players.txt',      
    }
  }

  if Minecraft::Server[${servername}]['banned_ips'] != undef {
    server_setting { "${servername}-banned-ips.txt":
      servername => $servername,
      filename => 'banned-ips.txt',      
    }
  }

  if Minecraft::Server[${servername}]['white_list_players'] != undef {
    server_setting { "${servername}-white-list.txt":
      servername => $servername,
      filename => 'white-list.txt',      
    }
  }
}
