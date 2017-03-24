class minecraft::service {


  if $facts['systemd'] {
    ::systemd::unit_file { 'minecraft.service':
      content => template('minecraft/minecraft.service.erb'),
      notify  => Service['minecraft'],
    }
  } else {
    file { 'minecraft_init':
      ensure  => present,
      path    => '/etc/init.d/minecraft',
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      content => template('minecraft/minecraft_init.erb'),
      notify  => Service['minecraft'],
    }
  }

  service { 'minecraft':
    ensure    => running,
    enable    => $minecraft::autostart,
  }
}
