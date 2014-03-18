class minecraft(
  $servers              = [ 'default', ]
  
  $user                 = 'minecraft',      # The user account for the Minecraft service
  $group                = 'minecraft',      # The user group for the Minecraft service
  $install_dir          = '/opt/minecraft', # Owned by user:group
  $home_dir             = $install_dir,        # Owned by user:group
  $source               = '1.7.5',          # Minecraft (semvar) or CraftBukkit ('recommended', 'beta', or 'dev'), or direct source (URL for wget)
  $autostart            = true,             # Start service at boot
  $manage_java          = true,             # Manage the JRE package
  $heap_size            = '1024',           # The maximum Java heap size in MB
  $heap_start           = '256',            # The initial Java heap size in MB
  $plugins              = {},               # Hash of plugins
  $ops                  = undef,
  $banned_players       = undef,
  $banned_ips           = undef,
  $white_list_players   = undef,

  # The following are server.properties attributes, see
  # http://minecraft.gamepedia.com/Server.properties for information
  # Empty strings are represented as empty in templates, unlike undef
  $generator_settings   = '',
  $op_permission_level  = 4,
  $allow_nether         = true,
  $level_name           = 'world',
  $enable_query         = false,
  $allow_flight         = false,
  $announce_achievments = true,
  $server_port          = 25565,
  $level_type           = 'DEFAULT',
  $enable_rcon          = false,
  $force_gamemode       = false,
  $level_seed           = '',
  $server_ip            = '',
  $max_build_height     = 256,
  $spawn_npcs           = true,
  $white_list           = false,
  $spawn_animals        = true,
  $snooper_enabled      = true,
  $hardcore             = false,
  $online_mode          = true,
  $resource_pack        = '',
  $pvp                  = true,
  $difficulty           = 1,
  $enable_command_block = false,
  $gamemode             = 0,
  $player_idle_timeout  = 0,
  $max_players          = 20,
  $spawn_monsters       = true,
  $gen_structures       = true,
  $view_distance        = 10,
  $spawn_protection     = 16,
  $motd                 = 'A Minecraft Server',
  ) {
  
  minecraft::server { $servers:
    user                 => $user,
    group                => $group,
    install_dir          => $install_dir
    home_dir             => $home_dir,
    source               => $source,
    autostart            => $autostart,
    manage_java          => $manage_java,
    heap_size            => $heap_size,
    heap_start           => $heap_start,
    plugins              => $plugins,
    ops                  => $ops,
    banned_players       => $banned_players,
    banned_ips           => $banned_ips,
    white_list_players   => $white_list_players,

    generator_settings   => $generator_settings,
    op_permission_level  => $op_permission_level,
    allow_nether         => $allow_nether,
    level_name           => $level_name,
    enable_query         => $enable_query,
    allow_flight         => $allow_flight,
    announce_achievments => $announce_acheivments,
    server_port          => $server_port,
    level_type           => $level_type,
    enable_rcon          => $enable_rcon,
    force_gamemode       => $force_gamemode,
    level_seed           => $level_seed,
    server_ip            => $server_ip,
    max_build_height     => $max_build_height,
    spawn_npcs           => $spawn_npcs,
    white_list           => $white_list,
    spawn_animals        => $spawn_animals,
    snooper_enabled      => $snooper_enabled,
    hardcore             => $hardcore,
    online_mode          => $online_mode,
    resource_pack        => $resource_pack,
    pvp                  => $pvp,
    difficulty           => $difficulty,
    enable_command_block => $enable_command_block,
    gamemode             => $gamemode,
    player_idle_timeout  => $player_idle_timeout,
    max_players          => $max_players,
    spawn_monsters       => $spawn_monsters,
    gen_structures       => $gen_structures,
    view_distance        => $view_distance,
    spawn_protection     => $spawn_protection,
    motd                 => $motd,
  }
}