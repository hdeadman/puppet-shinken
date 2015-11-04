class shinken::files (
  $ensure      = $shinken::ensure,
  $user        = $shinken::user,
  $group       = $shinken::group,
  $conf_dir    = $shinken::conf_dir,
  $modules_dir = $shinken::modules_dir,
  $daemons_dir = $shinken::daemons_dir,
) inherits shinken {

  $ensure_file = $ensure ? {
    present => file,
    absent  => absent,
  }
  $ensure_dir = $ensure ? {
    present => directory,
    absent  => absent,
  }

  $masters = ['arbiters', 'brokers', 'pollers', 'reactionners','receivers','schedulers']
  $dirs = union(['/etc/shinken','/var/lib/shinken','/var/log/shinken','/var/run/shinken'],
    [$modules_dir, $daemons_dir],
    prefix($masters, "${conf_dir}/"))
  file {$dirs:
    ensure => $ensure_dir,
    mode   => '0755',
    owner  => $user,
    group  => $group,
  }

  $conf_file=['brokers/broker-master.cfg',
              'arbiters/arbiter-master.cfg',
              'pollers/poller-master.cfg',
              'reactionners/reactionner-master.cfg',
              'receivers/receiver-master.cfg',
              'schedulers/scheduler-master.cfg']
  shinken::file { $conf_file:
    ensure => $ensure_file,
    path   => $conf_dir,
    mode   => '0644',
    owner  => $user,
    group  => $group,
  }

  $daemons = ['arbiterd.ini', 'brokerd.ini', 'pollerd.ini', 'reactionnerd.ini', 'receiverd.ini', 'schedulerd.ini']
  shinken::file { $daemons:
    ensure => $ensure_file,
    path   => $daemons_dir,
    mode   => '0644',
    owner  => $user,
    group  => $group,
  }
  
  $mod = ['webui2.cfg', 'mongodb.cfg']
  shinken::file { $mod:
    ensure => $ensure_file,
    path   => $modules_dir,
    mode   => '0644',
    owner  => $user,
    group  => $group,
  }
}
