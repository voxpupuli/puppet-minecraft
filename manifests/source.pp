define minecraft::source(
  $servername = $title,
  $server_dir,
  ) {

  $jar_name = 'minecraft_server'

  case $Minecraft::Server[${servername}]['source'] {
    /^(\d+)\.(\d+)\.(\d+)$/,    # Matches Semantic Versioning for vanilla Minecraft, see http://semver.org/
    /^(\d{2})w(\d{2})[a-z]$/: { # Matches current versioning scheme for vanilla Minecraft snapshots, uses the same download source URL
      $download = "https://s3.amazonaws.com/Minecraft.Download/versions/$Minecraft::Server[${servername}]['source']/minecraft_server.$Minecraft::Server[${servername}]['source'].jar"    }
    'recommended', 'rb', 'stable': {
      $download = 'http://dl.bukkit.org/latest-rb/craftbukkit.jar'
    }
    'beta', 'dev': {
      $download = "http://dl.bukkit.org/latest-$Minecraft::Server[${servername}]['source']/craftbukkit-$Minecraft::Server[${servername}]['source'].jar"
    }
    default: {
      $download = $Minecraft::Server[${servername}]['source']
    }
  }

  wget::fetch { "${servername}-minecraft":
    source      => $download,
    destination => "${server_dir}/${jar_name}.jar",
    user        => $Minecraft::Server[${servername}]['user'],
    group       => $Minecraft::Server[${servername}]['group'],
    #explicit user and group requires not needed, puppet will autorequire
  }
}
