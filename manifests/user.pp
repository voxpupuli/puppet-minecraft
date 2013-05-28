class minecraft::user {

  group { "$minecraft::group":
    ensure => present,
  }

  user { "$minecraft::user":
    gid        => "$minecraft::group",
    home       => "$minecraft::install_dir",
    managehome => true,
  }
}
