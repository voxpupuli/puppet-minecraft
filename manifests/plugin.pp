define minecraft::plugin(
  $plugin_name = $title,
  $source,
  $servername,
  ) {

  if $plugin_name =~ /\.jar$/ {
    fail("minecraft plugin name ${plugin_name} must not end in '.jar'")
  }
  
  wget::fetch { "${servername}-${plugin_name}":
    source      => $source,
    destination => "$Minecraft::Server[${servername}]['install_dir']/plugins/${plugin_name}.jar",
    user        => $Minecraft::Server[${servername}]['user'],
    notify      => Service["mc-${servername}"],
    require     => File["$Minecraft::Server[${servername}]['install_dir']/plugins"],
  }
}