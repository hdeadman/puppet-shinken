class shinken::service (
  $ensure = $shinken::ensure,
) inherits shinken {

  $service = $ensure ? {
    'present' => true,
    'absent'  => false,
  }
  service{ 'shinken':
    ensure     => $service,
    enable     => $service,
    hasrestart => $service,
    hasstatus  => $service,
  }

}