class minecraft::packages {

  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
      version      => 'latest',
    }
  }

  if ! defined( Package['screen'] ) {
    package { 'screen':
      ensure => present
      }
  }

  if ! defined( Package['curl'] ) {
    package { 'curl':
      ensure => present
    }
  }
}
