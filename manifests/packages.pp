class minecraft::packages {

  if $manage_java {
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
