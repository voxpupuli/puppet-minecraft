# Puppet Module for Minecraft

`puppet-minecraft` installs and configures your Minecraft server with Puppet!

## Usage

The simplest possible usage is

    class { 'minecraft': }

This entire class is parameterized, see minecraft class for details.

Parameters are available which control how the Minecraft installation
behaves:

  * `user`: The user account for the Minecraft service
  * `group`: The user group for the Minecraft service
  * `install_dir`: The directory in which Minecraft stores its data
  * `manage_java`: Should this module manage the `java` package?
  * `heap_size`: The maximum Java heap size for the Minecraft service in megabytes
  * `heap_start`: The initial Java heap size for the Minecraft service in megabytes

### Minecraft Versions / Bukkit Builds

A particular version of Minecraft server can be downloaded by
specifying the `version` parameter. Latest version as of this writing
is 1.7.4.

If [CraftBukkit](http://dl.bukkit.org/downloads/craftbukkit/) is
prefered, simply set the parameter `$source` to 'bukkit' (note that
source can also be set to a URL for a minecraft.jar download). If set,
`$version` is ignored, and `$bukkit_build` is used to specify
recommended (leave blank as ''), 'beta', or 'dev'.

### Server configuration

Full configuration of the Minecraft server is supported. Simply
specify the parameter with the server setting when declaring the
class:

    class { 'minecraft':
      motd => 'Managed by Puppet!'
	}

Note that the server property name will use an underscore
instead of a dash, and may not exactly match the `server.properties`
name.

### Managing players

This module manages the Minecraft player settings through
templates. To add players to a particular list, declare an array of
them (even if only one):

    class { 'minecraft':
	  ops						=> [ 'me' ],
	  banned_players			=> [ 'you' ],
	  banned_ips				=> [ '127.0.0.1' ], # Don't actually do this
	  white_list_players		=> [ 'my_best_friend' ] # Minecraft auto-includes ops
	}
