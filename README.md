# Puppet Module for Minecraft v2.1

`puppet-minecraft` installs and configures your Minecraft or
CraftBukkit server with Puppet!

This is a derivative work of Branan Purvine-Riley's
[Minecraft module](http://forge.puppetlabs.com/branan/minecraft), with
improvements including: version selection, CraftBukkit support, a
plugin resource, and settings managed via templates. It is released
under the original Apache License, Version 2.0.

This module has been tested on Ubuntu Server 12.04.3 with Puppet 3.4.1.

## Usage

The simplest possible usage is

    include minecraft

This entire class is parameterized, see the minecraft class for
details.

Parameters are available which control how the Minecraft installation
behaves:

  * `user`: The user account for the Minecraft service
  * `group`: The user group for the Minecraft service
  * `install_dir`: The directory in which Minecraft stores its data
  * `manage_java`: Should this module manage the `java` package?
  * `heap_size`: The maximum Java heap size for the Minecraft service
    in megabytes
  * `heap_start`: The initial Java heap size for the Minecraft service
    in megabytes

### Minecraft Versions / CraftBukkit Builds

A particular version of Minecraft server can be downloaded by
specifying the `source` parameter. This parameter accepts a semantic
version (representing a vanilla Minecraft server), or for a
[CraftBukkit](http://dl.bukkit.org/downloads/craftbukkit/)
installation, one of 'recommended', 'beta', or 'dev'. Latest vanilla
version as of this writing is 1.7.4.

Please note that once a JAR file (the server) has been downloaded to
`install_dir`, if you want to switch, you will need to manually remove
it so that the 'wget::fetch' resource can update; also beware
incompatibilities among Minecraft and CraftBukkit versions with world
files, settings, etc.

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
	  banned_ips				=> [ '127.0.0.1' ],     # Don't actually do this
	  white_list_players		=> [ 'my_best_friend' ] # Minecraft auto-includes ops
	}

Note that if one of these parameters is left as an empty array, Puppet
will not manage the corresponding file, allowing you to manage it via
commands in Minecraft. However, if specified, Puppet will manage the
file, and overwrite any manual changes on the next application of
Puppet. (There is also the "replace" attribute on the Puppet file
resource, but this is not what we want because, if the file is being
managed, we want changes in the manifest to be updated in the files.)

### Adding CraftBukkit Plugins

CraftBukkit plugins can be installed by using the defined resource
`minecraft::plugin`. You must specify the plugin name (lacking the
'.jar' file extension) and the complete URL for the download source.

### Copyright

My contributions as indicated by the git repository's history are
Copyright 2014 Andrew Schwartzmeyer, and as stated above, are released
under the included license.
