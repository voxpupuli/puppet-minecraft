# Definition: minecraft::ban
#
# This definition adds a player to the Minecraft server's ban list
#
define minecraft::ban ()
{
  file_line { $name:
    path   =>"${minecraft::install_dir}/banned-players.txt",
    line   => $name,
    notify => Service['minecraft'],
  }
}
