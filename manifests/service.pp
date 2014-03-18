define minecraft::service(
  $servername = $title,
  ) {

  file { "${servername}-minecraft_init":
    ensure  => present,
    path    => "/etc/init.d/minecraft.${servername}",
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('minecraft/minecraft_init.erb'),
  }

  service { "mc-${servername}":
    ensure    => running,
    enable    => $Minecraft::Server[${servername}]['autostart'],
    subscribe => File[ "${servername}-server.properties", 'minecraft_init' ],
  }
}