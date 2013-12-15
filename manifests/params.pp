class minecraft::params {
  $user                 = 'minecraft' # The user account for the Minecraft service
  $group                = 'minecraft' # The user group for the Minecraft service
  $install_dir          = '/opt/minecraft'
  $source               = 'vanilla'   # 'vanilla', 'bukkit', or direct source for wget
  $version              = '1.7.4'     # Minecraft version to download
  $bukkit_build         = ''          # '' (recommended), 'beta', or 'dev' build
  $manage_java          = true        # Manage jre package
  $heap_size            = '1024'      # The maximum Java heap size in MB
  $heap_start           = '256'       # The initial Java heap size in MB

  # The following are server.properties attributes, see
  # http://minecraft.gamepedia.com/Server.properties for information
  $generator_settings   = ''
  $op_permisison_level  = '4'
  $allow_nether         = 'true'
  $level_name           = 'world'
  $enable_query         = 'false'
  $allow_flight         = 'false'
  $announce_achievments = 'true'
  $server_port          = '25565'
  $level_type           = 'DEFAULT'
  $enable_rcon          = 'false'
  $force_gamemode       = 'false'
  $level_seed           = ''
  $server_ip            = ''
  $max_build_height     = '256'
  $spawn_npcs           = 'true'
  $white_list           = 'false'
  $spawn_animals        = 'true'
  $snooper_enabled      = 'true'
  $hardcore             = 'false'
  $online_mode          = 'true'
  $resource_pack        = ''
  $pvp                  = 'true'
  $difficulty           = '1'
  $enable_command_block = 'false'
  $gamemode             = '0'
  $player_idle_timeout  = '0'
  $max_players          = '20'
  $spawn_monsters       = 'true'
  $gen_structures       = 'true'
  $view_distance        = '10'
  $spawn_protection     = '16'
  $motd                 = 'A Minecraft Server'
}
