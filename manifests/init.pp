# Class: minecraft
#
# This class installs and configures a Minecraft server
#
# Parameters:
# - $user: The user account for the Minecraft service
# - $group: The user group for the Minecraft service
# - $install_dir: The directory in which Minecraft stores its data
# - $source: 'vanilla', 'bukkit', or direct source for wget
# - $manage_java: Should this module manage the `java` package?
# - $heap_size: The maximum Java heap size for the Minecraft service in megabytes
# - $heap_start: The initial Java heap size for the Minecraft service in megabytes
#

class minecraft(
  $user          = 'minecraft',
  $group         = 'minecraft',
  $install_dir   = '/opt/minecraft',
  $source        = 'vanilla',
  $manage_java   = true,
  $heap_size     = '1024',
  $heap_start    = '256') {

  class { 'minecraft::packages':
    before => Service['minecraft']
  }

  class { 'minecraft::user':
    before => [ Class['minecraft::settings'],
                Class['minecraft::source'] ]
  }

  class { 'minecraft::settings': }

  class { 'minecraft::source': }

  class { 'minecraft::start_script':
    before => Class['minecraft::service']
  }

  class { 'minecraft::service': }
}
