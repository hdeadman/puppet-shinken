class shinken::service (
  $ensure = $shinken::ensure,
) inherits shinken {

  $service = $ensure ? {
    'present' => true,
    'absent'  => false,
  }
  service{ 'shinken':
    ensure     => $service,
    provider   => 'init',
    enable     => $service,
    hasrestart => true,
    hasstatus  => true,
    path       => ['/etc/init.d'],
  }

}