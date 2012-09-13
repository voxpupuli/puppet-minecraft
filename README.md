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
