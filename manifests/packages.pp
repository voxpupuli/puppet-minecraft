class minecraft::packages {

  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
      version      => 'latest',
    }
  }

  $packages = [ 'screen', 'curl' ]
  ensure_resource('package', $packages, {'ensure' => 'present' })
}
