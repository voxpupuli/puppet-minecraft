# Puppet Module for Minecraft

`puppet-minecraft` installs and configures your Minecraft server with Puppet!

## Usage

The simplest possible usage is

    class { 'minecraft': }

Parameters are available which control how the Minecraft installation
behaves:

  * `user`: The user account for the Minecraft service
  * `group`: The user group for the Minecraft service
  * `homedir`: The directory in which Minecraft stores its data
  * `manage_java`: Should this module manage the `java` package?
  * `manage_screen`: Should this module manage the `screen` package?
  * `manage_curl`: Should this module manage the `curl` package?
  * `heap_size`: The maximum Java heap size for the Minecraft service in megabytes
  * `heap_start`: The initial Java heap size for the Minecraft service in megabytes`

## Server configuration

Full configuration of the Minecraft server is supported. Simply use
the `minecraft::server_prop` type.

    minecraft::server_prop { 'spawn-monsters':
      value => 'true'
    }

Consult your favorite Minecraft resource for the full list of server
properties.

## Managing players

This module includes several Puppet defines to allow managing the
players on your server

  * `minecraft::op { $player: }`: Add `$player` to the auto-op list
  * `minecraft::whitelist { $player: }`: Add `$player` to the server whitelist
  * `minecraft::ban { $player: }`: Add `$player` to the server ban list
  * `minecraft::ipban { $ipaddr: }`: Add `$ipaddr` to the server ip-ban list
