define shinken::module (
  $ensure   = $ensure,
  $mod_name = $title,
){
  if ($ensure in ['present', true]) {
    exec{"install_${mod_name}":
      command => "/usr/bin/shinken install ${mod_name}",
      unless  => "/usr/bin/shinken inventory | grep \"^${mod_name}$\" 2>/dev/null",
    }
  }
}