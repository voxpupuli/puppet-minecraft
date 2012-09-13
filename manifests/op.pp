define minecraft::op ()
{
  file_line { $name:
    path   =>"${minecraft::homedir}/ops.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
