class minecraft::packages {

  if $::minecraft::manage_java {
    class { '::java':
      distribution => 'jre',
      version      => 'latest',
    }
  }

  ensure_packages('screen')
}
