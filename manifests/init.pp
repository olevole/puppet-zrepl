# manage zrepl
class zrepl(
  String $config_dir,
  String $config_name,
  String $config_owner,
  String $config_group,
  String $config_mode,
  String $bin_dir,
  String $cfg_verify_cmd,
  Hash   $global,
  Array  $jobs,
) {

  contain zrepl::service_reload

#Class['prometheus::install']
#  -> Class['prometheus::config']
#  -> Class['prometheus::run_service'] # Note: config must *not* be configured here to notify run_service.  Some resources in config.pp need to notify service_reload instead
#  -> Class['prometheus::service_reload']


    file { 'zrepl.yml':
      ensure       => file,
      path         => "${config_dir}/${config_name}",
      owner        => $zrepl::config_owner,
      group        => $zrepl::config_group,
      mode         => $zrepl::config_mode,
      notify       => Class['zrepl::service_reload'],
      content      => template('zrepl/zrepl.yml.erb'),
      validate_cmd => "${zrepl::bin_dir} ${cfg_verify_cmd} %",
    }

}
