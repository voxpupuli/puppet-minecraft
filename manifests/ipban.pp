define minecraft::ipban ()
{
  file_line { $name:
    path   =>"${minecraft::homedir}/banned-ips.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
