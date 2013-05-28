class minecraft::packages {

  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
    }
  }

  package { 'screen':
    ensure => present
  }

  package { 'curl':
    ensure => present
  }
}
