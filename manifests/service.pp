class minecraft::service {

  service { 'minecraft':
    ensure    => running,
    require   => File['minecraft_init'],
    subscribe => Wget::Fetch['minecraft'],
  }
}
