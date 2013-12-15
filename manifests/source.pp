class minecraft::source {

  if $bukkit_build != '' {
    $bukkit_build = "-${bukkit_build}"
  }

  $bukkit_source = "http://cbukk.it/craftbukkit${bukkit_build}.jar"

  $vanilla_source = "https://s3.amazonaws.com/Minecraft.Download/versions/${version}/minecraft_server.${version}.jar"

  case $minecraft::source {
    'bukkit':               { $download = $bukkit_source }
    'vanilla', 'minecraft': { $download = $vanilla_source }
    default:                { $download = $source }
  }

  wget::fetch { 'minecraft':
    source      => $download,
    destination => "${install_dir}/minecraft_server.jar",
  }
}
