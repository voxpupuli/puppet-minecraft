define minecraft::user(
  $servername = $title,
  ) {

#  group { $minecraft::group:
#    ensure     => present,
#  }
  ensure_resource('group', $Minecraft::Server[${servername}]['group'],
    {'ensure' => 'present',
    })

#  user { $minecraft::user:
#    ensure     => present,
#    gid        => $minecraft::group,
#    home       => $minecraft::home_dir,
#    managehome => true,
#    require    => Group[$minecraft::group]
#  }
  ensure_resource('user', $Minecraft::Server[${servername}]['user'],
    {'ensure'     => 'present',
     'gid'        => $Minecraft::Server[{$servername}]['group'],
     'home'       => '/opt/minecraft',
     'managehome' => true,
     'require'    => Group[$Minecraft::Server[{$servername}]['group']],
    })

#  file { $minecraft::home_dir:
#    ensure  => directory,
#    owner   => $minecraft::user,
#    group   => $minecraft::group,
#    require => User[$minecraft::user], Group[$minecraft::group],
#  }
  ensure_resource('file', $Minecraft::Server[${servername}]['home_dir'],
    {'ensure'  => 'directory',
     'owner'   => $Minecraft::Server[${servername}]['user'],
     'group'   => $Minecraft::Server[{$servername}]['group'],
    })
  }
}