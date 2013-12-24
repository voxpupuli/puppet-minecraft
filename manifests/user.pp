class minecraft::user {

  group { $group:
    ensure     => present,
  }

  user { $user:
    gid        => $group,
    home       => $install_dir,
    managehome => true,
  }

}
