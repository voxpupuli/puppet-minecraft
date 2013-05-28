# Definition: minecraft::whitelist
#
# This definition adds a player to the Minecraft server's whitelist
#
define minecraft::whitelist ()
{
  file_line { $name:
    path   =>"${minecraft::install_dir}/white-list.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
