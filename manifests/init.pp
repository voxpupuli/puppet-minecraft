# Class: minecraft
#
# This class installs and configures a Minecraft server
#

class minecraft(
  $user = $minecraft::params::user,
  $group = $minecraft::params::group,
  $install_dir = $minecraft::params::install_dir,
  $source = $minecraft::params::source,
  $version = $minecraft::params::version,
  $bukkit_build = $minecraft::params::bukkit_build,
  $manage_java = $minecraft::params::manage_java,
  $heap_size = $minecraft::params::heap_size,
  $heap_start = $minecraft::params::heap_start,


  $generator_settings = $minecraft::params::generator_settings,
  $op_permisison_level = $minecraft::params::op_permission_level,
  $allow_nether = $minecraft::params::allow_nether,
  $level_name = $minecraft::params::level_name,
  $enable_query = $minecraft::params::enable_query,
  $allow_flight = $minecraft::params::allow_flight,
  $announce_achievments = $minecraft::params::announce_achievments,
  $server_port = $minecraft::params::server_port,
  $level_type = $minecraft::params::level_type,
  $enable_rcon = $minecraft::params::enable_rcon,
  $force_gamemode = $minecraft::params::force_gamemode,
  $level_seed = $minecraft::params::level_seed,
  $server_ip = $minecraft::params::server_ip,
  $max_build_height = $minecraft::params::max_build_height,
  $spawn_npcs = $minecraft::params::spawn_npcs,
  $white_list = $minecraft::params::white_list,
  $spawn_animals = $minecraft::params::spawn_animals,
  $snooper_enabled = $minecraft::params::snooper_enabled,
  $hardcore = $minecraft::params::hardcore,
  $online_mode = $minecraft::params::online_mode,
  $resource_pack = $minecraft::params::resource_pack,
  $pvp = $minecraft::params::pvp,
  $difficulty = $minecraft::params::difficulty,
  $enable_command_block = $minecraft::params::enable_command_block,
  $gamemode = $minecraft::params::gamemode,
  $player_idle_timeout = $minecraft::params::player_idle_timeout,
  $max_players = $minecraft::params::max_players,
  $spawn_monsters = $minecraft::params::spawn_monsters,
  $gen_structures = $minecraft::params::gen_structures,
  $view_distance = $minecraft::params::view_distance,
  $spawn_protection = $minecraft::params::spawn_protection,
  $motd = $minecraft::params::motd,
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

  class { 'minecraft::source': }

  class { 'minecraft::start_script':
    before => Class['minecraft::service']
  }

  class { 'minecraft::service': }
}
