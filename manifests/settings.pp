class minecraft::settings {

  file { "${minecraft::install_dir}/ops.txt":
    ensure => present,
    owner  => $minecraft::user,
    group  => $minecraft::group,
    mode   => '0664',
  } -> Minecraft::Op <| |>

  file { "${minecraft::install_dir}/banned-players.txt":
    ensure => present,
    owner  => $minecraft::user,
    group  => $minecraft::group,
    mode   => '0664',
  } -> Minecraft::Ban <| |>

  file { "${minecraft::install_dir}/banned-ips.txt":
    ensure => present,
    owner  => $minecraft::user,
    group  => $minecraft::group,
    mode   => '0664',
  } -> Minecraft::Ipban <| |>

  file { "${minecraft::install_dir}/white-list.txt":
    ensure => present,
    owner  => $minecraft::user,
    group  => $minecraft::group,
    mode   => '0664',
  } -> Minecraft::Whitelist <| |>
}
