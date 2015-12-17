class shinken::packages (
  $ensure = $shinken::params::ensure,
  $plugin_packages = $shinken::params::plugin_packages,
  $cherrypy_package = $shinken::params::cherrypy_package,
  $install_lsb      = true,
) inherits shinken::params {

  shinken::undef_package { $plugin_packages:
    ensure => $ensure,
  }
 
  $packages = ['python-pip',
    'python-pycurl',
    $cherrypy_package,
    'python-crypto',
    'mongodb',
    'python-pymongo']

  shinken::undef_package { $packages:
    ensure => $ensure,
  }
  
  # redhat needs lsb
  if ($install_lsb and $::osfamily == 'RedHat') {
    shinken::undef_package { 'redhat-lsb-core' : ensure => present }
  }

}