# Class: minecraft
#
# This class installs and configures a Minecraft server
#
# Parameters:
# - $user: The user account for the Minecraft service
# - $group: The user group for the Minecraft service
# - $homedir: The directory in which Minecraft stores its data
# - $manage_java: Should this module manage the `java` package?
# - $manage_screen: Should this module manage the `screen` package?
# - $manage_curl: Should this module manage the `curl` package?
# - $heap_size: The maximum Java heap size for the Minecraft service in megabytes
# - $heap_start: The initial Java heap size for the Minecraft service in megabytes
#
# Sample Usage:
#
#  class { 'minecraft':
#    user      => 'mcserver',
#    group     => 'mcserver',
#    heap_size => 4096,
#  }
#
class minecraft(
  $user          = 'mcserver',
  $group         = 'mcserver',
  $homedir       = '/opt/minecraft',
  $manage_java   = true,
  $manage_screen = true,
  $manage_curl   = true,
  $heap_size     = 2048,
  $heap_start    = 512,
)
{
  if $manage_java {
    class { 'java':
      distribution => 'jre',
      before       => Service['minecraft']
    }
  }

  if $manage_screen {
    package {'screen':
      before => Service['minecraft']
    }
  }

  if $manage_curl {
    package {'curl':
      before => S3file["${homedir}/minecraft_server.jar"],
    }
  }

  group { $group:
    ensure => present,
  }

  user { $user:
    gid        => $group,
    home       => $homedir,
    managehome => true,
  }

  s3file { "${homedir}/minecraft_server.jar":
    source  => 'MinecraftDownload/launcher/minecraft_server.jar',
    require => User[$user],
  }

  file { "${homedir}/ops.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Op<| |>

  file { "${homedir}/banned-players.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Ban<| |>

  file { "${homedir}/banned-ips.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Ipban<| |>

  file { "${homedir}/white-list.txt":
    ensure => present,
    owner  => $user,
    group  => $group,
    mode   => '0664',
  } -> Minecraft::Whitelist<| |>

  file { '/etc/init.d/minecraft':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('minecraft/minecraft_init.erb'),
  }

  service { 'minecraft':
    ensure    => running,
    require   => File['/etc/init.d/minecraft'],
    subscribe => S3file["${homedir}/minecraft_server.jar"],
  }
}
