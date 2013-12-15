class minecraft::settings {

  file { "${install_dir}/server.properties":
    ensure  => file,
    content => template('minecraft/server.properties.erb'),
    owner   => $user,
    group   => $group,
    mode    => '0664',
  }

  file { "${install_dir}/ops.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Op <| |>

  file { "${install_dir}/banned-players.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Ban <| |>

  file { "${install_dir}/banned-ips.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Ipban <| |>

  file { "${install_dir}/white-list.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Whitelist <| |>
}
