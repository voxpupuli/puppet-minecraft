class minecraft::user {

  group { $minecraft::group:
    ensure     => present,
  }

  user { $minecraft::user:
    ensure     => present,
    gid        => $minecraft::group,
    home       => $minecraft::install_dir,
    managehome => true,
    require    => Group[$minecraft::group]
  }

  # Ensures deletion of install_dir does not break module, setup for plugins
  $dirs = [ $minecraft::install_dir, "${minecraft::install_dir}/plugins" ]

  file { $dirs:
    ensure  => directory,
    owner   => $minecraft::user,
    group   => $minecraft::group,
    require => User[$minecraft::user],
  }
}
