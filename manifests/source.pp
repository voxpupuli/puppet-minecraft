class minecraft::source {

  $jar_name = 'minecraft_server'

  case $minecraft::source {
    /^(\d+)\.(\d+)\.(\d+)$/,    # Matches Semantic Versioning for vanilla Minecraft, see http://semver.org/
    /^(\d{2})w(\d{2})[a-z]$/: { # Matches current versioning scheme for vanilla Minecraft snapshots, uses the same download source URL
      $download = "https://s3.amazonaws.com/Minecraft.Download/versions/${minecraft::source}/minecraft_server.${minecraft::source}.jar"
    }
    # Downloads latest type of Bukkit server
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

  archive { 'minecraft_server':
    ensure  => 'present',
    source  => $download,
    path    => "${minecraft::install_dir}/minecraft_server.jar",
    require => [User[$minecraft::user],File[$minecraft::install_dir]],
    user    => $minecraft::user,
  }

  file { "${minecraft::install_dir}/minecraft_server.jar":
    ensure  => 'file',
    owner   => $minecraft::user,
    group   => $minecraft::group,
    mode    => '0644',
    require => [User[$minecraft::user],
                Group[$minecraft::group],
                Archive['minecraft_server'],
    ],
  }

}
