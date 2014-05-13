define minecraft::user(
  $servername = $title,
  $user, $group, $home_dir,
  ) {

  ensure_resource('group', $group,
    { 'ensure' => 'present', })

  ensure_resource('user', $user,
    { 'ensure'     => 'present',
      'gid'        => $group,
      'home'       => $home_dir,
      'managehome' => true, })

  ensure_resource('file', $home_dir,
    { 'ensure'  => 'directory',
      'owner'   => $user,
      'group'   => $group, })
  }
}
