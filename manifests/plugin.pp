define minecraft::plugin(
  $plugin_name = $title,
  $source,
  $servername,
  $server_dir,
  ) {

  if $plugin_name =~ /\.jar$/ {
    fail("minecraft plugin name ${plugin_name} must not end in '.jar'")
  }
  
  wget::fetch { "${servername}-${plugin_name}":
    source      => $source,
    destination => "${server_dir}/plugins/${plugin_name}.jar",
    user        => $Minecraft::Server[${servername}]['user'],
    notify      => Service["mc-${servername}"],
    #Parent directories are autorequired if managed
  }
}
