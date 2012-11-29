# Definition: minecraft::whitelist
#
# This definition adds a player to the Minecraft server's whitelist
#
define minecraft::whitelist ()
{
  file_line { $name:
    path   =>"${minecraft::homedir}/white-list.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
