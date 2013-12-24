# Class: minecraft
#
# This class installs and configures a Minecraft server
#

class minecraft(
  $user
  $group
  $install_dir
  $source
  $version
  $bukkit_build
  $manage_java
  $heap_size
  $heap_start
  $ops
  $banned_players
  $banned_ips
  $white_list_players

  $generator_settings
  $op_permisison_level
  $allow_nether
  $level_name
  $enable_query
  $allow_flight
  $announce_achievments
  $server_port
  $level_type
  $enable_rcon
  $force_gamemode
  $level_seed
  $server_ip
  $max_build_height
  $spawn_npcs
  $white_list
  $spawn_animals
  $snooper_enabled
  $hardcore
  $online_mode
  $resource_pack
  $pvp
  $difficulty
  $enable_command_block
  $gamemode
  $player_idle_timeout
  $max_players
  $spawn_monsters
  $gen_structures
  $view_distance
  $spawn_protection
  $motd
) inherits minecraft::params {

  class { 'minecraft::packages':
    before => Service['minecraft']
  }

  class { 'minecraft::user':
    before => [ Class['minecraft::settings'],
                Class['minecraft::source'] ]
  }

  class { 'minecraft::settings': 
     before => Service['minecraft']
  }

  class { 'minecraft::source': 
    before => Service['minecraft']
  }

  class { 'minecraft::start_script':
    before => Class['minecraft::service']
  }

  class { 'minecraft::service': }
}
