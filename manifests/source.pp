class minecraft::source {

  if $minecraft::bukkit_build != '' {
    $bukkit_build = "-${minecraft::bukkit_build}"
  }

  $bukkit_source = "http://cbukk.it/craftbukkit${bukkit_build}.jar"

  $vanilla_source = "https://s3.amazonaws.com/Minecraft.Download/versions/${minecraft::version}/minecraft_server.${minecraft::version}.jar"

  case $minecraft::source {
    'bukkit':               { $download = $bukkit_source }
    'vanilla', 'minecraft': { $download = $vanilla_source }
    default:                { $download = $minecraft::source }
  }

  wget::fetch { 'minecraft':
    source      => $download,
    destination => "${minecraft::install_dir}/minecraft_server.jar",
  }

  file { "${minecraft::install_dir}/plugins":
    ensure => directory,
    owner  => $minecraft::user,
    group  => $minecraft::group,
  }
}
