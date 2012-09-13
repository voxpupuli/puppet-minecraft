define minecraft::ban ()
{
  file_line { $name:
    path   =>"${minecraft::homedir}/banned-players.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
