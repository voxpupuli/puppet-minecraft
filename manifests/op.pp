# Definition: minecraft::op
#
# This definition adds a player to the Minecraft server's auto-op list
#
define minecraft::op ()
{
  file_line { $name:
    path   =>"${minecraft::install_dir}/ops.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
