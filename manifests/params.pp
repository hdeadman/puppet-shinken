class shinken::params ()
{

  $ensure      = 'present'
  $user        = 'shinken'
  $group       = 'shinken'
  $modules     = []
  $conf_dir    = '/etc/shinken'
  $modules_dir = '/etc/shinken/modules'
  $daemons_dir = '/etc/shinken/daemons'
 
  case $::operatingsystem {
    'RedHat', 'CentOS': { 
    	$plugin_packages = ['nagios-plugins-all'] 
    	$cherrypy_package = 'python-cherrypy'
    }
    /^(Debian|Ubuntu)$/: { 
      $plugin_packages = ['nagios-plugins-standard']
      $cherrypy_package = 'python-cherrypy3' 
    }
    default: {
      $plugin_packages = ['nagios-plugins-standard']
      $cherrypy_package = 'python-cherrypy' 
    }
  }
  
}