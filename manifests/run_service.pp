# @summary This class is meant to be called from zrepl. It ensure the service is running
class zrepl::run_service {

  $init_selector = $zrepl::init_style ? {
    'launchd' => 'io.zrepl.daemon',
    default   => $zrepl::service_name,
  }

  if $zrepl::manage_service == true {
    service { 'zrepl':
      ensure => $zrepl::service_ensure,
      name   => $init_selector,
      enable => $zrepl::service_enable,
    }
  }
}
