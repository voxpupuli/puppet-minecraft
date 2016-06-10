define minecraft::plugin(
  $source,
  $plugin_name  = $title
) {

  if $plugin_name =~ /^.*\.jar$/ {
    fail("minecraft plugin title ${plugin_name} must not end in '.jar'")
  }

  archive { $plugin_name:
    ensure  => 'present',
    source  => $source,
    path    => "${minecraft::install_dir}/plugins/${plugin_name}.jar",
    notify  => Service['minecraft'],
    require => File["${minecraft::install_dir}/plugins"],
    user    => $minecraft::user,
  }

  file { "${minecraft::install_dir}/plugins/${plugin_name}.jar":
    ensure  => 'file',
    owner   => $minecraft::user,
    group   => $minecraft::group,
    mode    => '0644',
    require => Archive[$plugin_name],
  }
}
