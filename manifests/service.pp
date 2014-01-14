class minecraft::service {

  file { 'minecraft_init':
    ensure  => present,
    path    => '/etc/init.d/minecraft',
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('minecraft/minecraft_init.erb'),
  }

  service { 'minecraft':
    ensure    => running,
    enable    => $minecraft::autostart,
    subscribe => File[ 'server.properties', 'minecraft_init' ],
  }
}
