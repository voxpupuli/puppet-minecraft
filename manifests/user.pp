class minecraft::user {

  group { $minecraft::group:
    ensure     => present,
  }

  user { $minecraft::user:
    ensure     => present,
    gid        => $minecraft::group,
    home       => $install_dir,
    managehome => true,
    require => Group['minecraft']
  }

}
