# Class: minecraft::params
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
# All following are Minecraft server.properties settings
#

class minecraft::params {
  $user = 'minecraft'
  $group = 'minecraft'
  $install_dir = '/opt/minecraft'
  $source = 'vanilla'
  $manage_java = true
  $heap_size = '1024'
  $heap_start = '256'

  $generator_settings = ''
  $op_permisison_level = '4'
  $allow_nether = 'true'
  $level_name = 'world'
  $enable_query = 'false'
  $allow_flight = 'false'
  $announce_achievments = 'true'
  $server_port = '25565'
  $level_type = "DEFAULT"
  $enable_rcon = 'false'
  $force_gamemode = 'false'
  $level_seed = ''
  $server_ip = ''
  $max_build_height = '256'
  $spawn_npcs = 'true'
  $white_list = 'false'
  $spawn_animals = 'true'
  $snooper_enabled = 'true'
  $hardcore = 'false'
  $online_mode = 'true'
  $resource_pack = ''
  $pvp = 'true'
  $difficulty = '1'
  $enable_command_block = 'false'
  $gamemode = '0'
  $player_idle_timeout = '0'
  $max_players = '20'
  $spawn_monsters = 'true'
  $gen_structures = 'true'
  $view_distance = '10'
  $spawn_protection = '16'
  $motd = 'A Minecraft Server'
}
