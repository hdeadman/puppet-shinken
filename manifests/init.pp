# == Class: shinken
#
# Full description of class shinken here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'shinken':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class shinken (
  $ensure      = $shinken::params::ensure,
  $user        = $shinken::params::user,
  $group       = $shinken::params::group,
  $modules     = $shinken::params::modules,
  $conf_dir    = $shinken::params::conf_dir,
  $modules_dir = $shinken::params::modules_dir,
  $daemons_dir = $shinken::params::daemons_dir,
) inherits shinken::params {

  validate_string($user)
  validate_string($group)
  validate_array($modules)

  if ($ensure in ['present', true]) {
    class { 'shinken::users': }->
    class { 'shinken::dirs': }->
    class { 'shinken::install': }->
    class { 'shinken::files': }->
    class { 'shinken::service': }
  } elsif ($ensure in ['absent', false]) {
    class { 'shinken::service':
      ensure => absent,
    }
    class { 'shinken::install':
      ensure => absent,
    }
    class { 'shinken::files':
      ensure => absent,
    }
    class { 'shinken::dirs':
      ensure => absent,
    }
    class { 'shinken::users':
      ensure => absent,
    }
  } else {
    notify{"Parameter ensure => ${ensure} is not managed.":}
  }

}