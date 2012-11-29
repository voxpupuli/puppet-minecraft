# Definition: minecraft::ipban
#
# This definition adds an ip address to the Minecraft server's banned ip list
#
define minecraft::ipban ()
{
  file_line { $name:
    path   =>"${minecraft::homedir}/banned-ips.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
