class minecraft::packages {
  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
      version      => 'latest',
    }
  }

  if $minecraft::manage_screen {
    ensure_packages('screen')
  }
}
