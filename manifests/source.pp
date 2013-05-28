class minecraft::source {

  $bukkit_source = 'http://cbukk.it/craftbukkit-beta.jar'

  $vanilla_source = 'https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar'

  case $minecraft::source {
    'bukkit':               { $download = $bukkit_source }
    'vanilla', 'minecraft': { $download = $vanilla_source }
    default:                { $download = $minecraft::source }
  }

  wget::fetch { 'minecraft':
    source => $download,
    destination => '${minecraft::install_dir}/minecraft_server.jar',
  }
}
