class shinken::service (
  $ensure = $shinken::ensure,
) inherits shinken {

  $service = $ensure ? {
    'present' => true,
    'absent'  => false,
  }
  
  #exported nagios config resources are read-only by root
  exec { 'fix-permissions':
     command     => "find /etc/shinken/hosts -type f -name '*cfg' | xargs chmod go+r",
     path        => ["/usr/bin"],
     refreshonly => true,
  } ->   
  service{ 'shinken':
    ensure     => $service,
    enable     => $service,
    hasrestart => $service,
    hasstatus  => $service,
  }

}