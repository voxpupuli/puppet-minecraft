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

The simplest possible usage is:

```puppet
include minecraft
```

This entire class is parameterized (see the minecraft class for
details), and can be configured through hiera.

Parameters are available which control how the Minecraft installation
behaves:

  * `user`: The user account for the Minecraft service
  * `group`: The user group for the Minecraft service
  * `install_dir`: The directory in which Minecraft stores its data
  * `source`: Minecraft (semvar) or CraftBukkit ('recommended',
    'beta', or 'dev'), or direct source (URL for `wget`)
  * `autostart`: Start the service at boot
  * `manage_java`: Manage the JRE package
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
it so that the `wget::fetch` resource can update; also beware
incompatibilities among Minecraft and CraftBukkit versions with world
files, settings, etc.

### Server configuration

Full configuration of the Minecraft server is supported. Simply
specify the parameter with the server setting when declaring the
class:

```puppet
class { 'minecraft':
  source     => 'dev',
  heap_size  => 2048,
  difficulty => 2,
  motd       => 'Managed by Puppet!',
  ops        => [ 'op1', 'op2' ]
}
```

[Hiera](http://docs.puppetlabs.com/hiera/1/puppet.html) configuration
can also be done. In [YAML](http://www.yaml.org/):

```yaml
minecraft::source: 'dev'
minecraft::heap_size: 2048
minecraft::difficulty: 2
minecraft::motd: 'Managed by Puppet, with Hiera!'
minecraft::ops: 
  - 'op1'
  - 'op2'
```

Note that the server property name will use an underscore instead of a
dash, and may not exactly match the `server.properties` name. Also,
refrain from using 'undef' for the server properties, as Puppet will
place 'undef' as a string in the template; instead, use the emptry
string: ''. (It's either this or add a bunch of template logic to
check for an undef value first, for every parameter, do it and Pull
Request if you'd like.)

### Managing players

This module manages the Minecraft player settings through
templates. To add players to a particular list, declare an array of
them:

```puppet
class { 'minecraft':
  ops                => 'me',
  banned_players     => [ 'griefer', 'badboy' ],
  banned_ips         => '127.0.0.1',         # Don't actually do this
  white_list_players => [ 'my_best_friend' ] # Minecraft auto-includes ops
}
```

Note that when any of these parameters is set to undef, Puppet will
not manage the corresponding file, allowing you to manage it via
commands in Minecraft. However, if specified, Puppet will manage the
file, and overwrite any manual changes on the next application of
Puppet. (There is also the "replace" attribute on the Puppet file
resource, but this is not what we want because, if the file is being
managed, we want changes in the manifest to be updated in the files.)

To enable the whitelist, you must both set it to true in the class,
and add players to the whitelist here, as they affect separate
templates. Additionally, blacklists (banned IPs/players) is pointless
if the whitelist is enabled, and is only shown here concurrently for
demonstration purposes.

### Java

If `manage_java` is true, this module will use
[Puppetlabs' Java module](https://github.com/puppetlabs/puppetlabs-java)
to install the necessary Java Runtime Environment.

Note that for Ubuntu 12.04, there is currently a
[bug](https://bugs.launchpad.net/ubuntu/+source/tzdata/+bug/1212319)
with openjdk-7-jre-headless because of a broken dependency (tzdata)
that likely has been upgraded. To fix, manually install the
aforementioned Java package using aptitude (not apt-get), and accept
the conflict resolution that downgrades tzdata (may be the second
choice).

### Adding CraftBukkit Plugins

CraftBukkit plugins can be installed by using the defined resource
`minecraft::plugin`. You must specify the plugin name (lacking the
'.jar' file extension) and the complete URL for the download source.

#### Dynmap Example

The
[Dynmap plugin](http://www.minecraftforum.net/topic/1543523-dynmap-dynamic-web-based-maps-for-minecraft/)
can be configured like this:

```puppet
minecraft::plugin { 'dynmap':
  source => 'http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar'
}
```

Or using Hiera like this:

```yaml
minecraft::plugins:
  dynmap:
    source: http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar
```

Once enabled, a web-based map of the server will be available at
[localhost:8123](http://localhost:8123). James Fryman's
[nginx module](http://forge.puppetlabs.com/jfryman/nginx) could then
be used to proxy the server through
[map.domain.tld](http://map.domain.tld) like thus:

```puppet
nginx::resource::vhost { 'map.domain.tld':
  proxy            => 'http://localhost:8123',
  proxy_set_header => [ 'Host $host' ],
}
```

Or again in Hiera,

```yaml
nginx::nginx_vhosts:
  map.domain.tld:
    proxy: http://localhost:8123
    proxy_set_header:
	  - Host $host
```

Note that Nginx setup is not within the scope of this module, and is
simply provided as a tip.

### Caveats

This package uses
[Puppetlabs' stdlib module](https://forge.puppetlabs.com/puppetlabs/stdlib)
for the `ensure_resource` function, which it uses on the `screen`
package (utilized for running the Minecraft server as a background
service). This is currently the safest way to declare a
possibly-conflicting dependency.

### Copyright

My contributions as indicated by the git repository's history are
Copyright 2014 Andrew Schwartzmeyer, and as stated above, are released
under the included license.
