# manage zrepl
class zrepl(
  String                  $config_dir,
  String                  $config_name,
  String                  $config_owner,
  String                  $config_group,
  String                  $config_mode,
  String                  $bin_dir,
  String                  $cfg_verify_cmd,
  Hash                    $global,
  Array                   $jobs,
  String                  $package_name,
  Boolean                 $manage_service,
  Boolean                 $service_enable,
  Stdlib::Ensure::Service $service_ensure    = 'running',
  Boolean                 $restart_on_change = true,
  String                  $init_style        = $facts['service_provider'],
  String                  $service_name,
) {

  contain zrepl::install
  contain zrepl::config
  contain zrepl::run_service
  contain zrepl::service_reload

  Class['zrepl::install']
  -> Class['zrepl::config']
  -> Class['zrepl::run_service']
  -> Class['zrepl::service_reload']

}
