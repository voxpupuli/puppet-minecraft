# Definition: minecraft::server_prop
#
# This definition sets a configuration option in the Minecraft
# server.properties file
#
# Parameters:
# - $value: What the property should be set to
#
# Sample Usage:
#
#  minecraft::server_prop { 'spawn-monsters':
#    value => 'true'
#  }
#
define minecraft::server_prop (
  $value,
)
{
  file_line { $name:
    path   => "${minecraft::homedir}/server.properties",
    line   => "${name}=${value}",
    match  => "${name}=.*",
    notify => Service['minecraft'],
  }
}
