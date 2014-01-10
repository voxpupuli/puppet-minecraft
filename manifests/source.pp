class minecraft::source {

  $jar_name = 'minecraft_server'

  case $minecraft::source {
    /^(\d+)\.(\d+)\.(\d+)$/: { # Matches Semantic Versioning for vanilla Minecraft, see http://semver.org/
      $download = "https://s3.amazonaws.com/Minecraft.Download/versions/${minecraft::source}/minecraft_server.${minecraft::source}.jar"
    }
    'recommended', 'rb', 'stable': {
      $download = 'http://dl.bukkit.org/latest-rb/craftbukkit.jar'
    }
    'beta', 'dev': {
      $download = "http://dl.bukkit.org/latest-${minecraft::source}/craftbukkit-${minecraft::source}.jar"
    }
    default: {
      $download = $minecraft::source
    }
  }

  wget::fetch { 'minecraft':
    source      => $download,
    destination => "${minecraft::install_dir}/minecraft_server.jar",
    require     => User[$minecraft::user],
  }
}
