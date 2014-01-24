define minecraft::plugin($plugin_name = $title, $source) {

  if $plugin_name =~ /^.*\.jar$/ {
    fail("minecraft plugin name ${plugin_name} must not end in '.jar'")
  }
  
  wget::fetch { $plugin_name:
    source      => $source,
    destination => "${minecraft::install_dir}/plugins/${plugin_name}.jar",
    user        => $minecraft::user,
    notify      => Service['minecraft'],
    require     => File["${minecraft::install_dir}/plugins"],
  }
}
