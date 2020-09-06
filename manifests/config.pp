# manage zrepl
class zrepl::config {
  assert_private()

  file { $zrepl::config_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => $zrepl::group,
    mode    => $zrepl::config_mode,
#    purge   => $zrepl::purge_config_dir,
#    recurse => $zrepl::purge_config_dir,
#    force   => $zrepl::purge_config_dir,
  }

  $notify = $zrepl::restart_on_change ? {
    true    => Class['zrepl::run_service'],
    default => undef,
  }

  file { 'zrepl.yml':
    ensure       => file,
    path         => "${zrepl::config_dir}/${zrepl::config_name}",
    owner        => $zrepl::config_owner,
    group        => $zrepl::config_group,
    mode         => $zrepl::config_mode,
    notify       => Class['zrepl::service_reload'],
    content      => template('zrepl/zrepl.yml.erb'),
    validate_cmd => "${zrepl::bin_dir}/zrepl ${zrepl::cfg_verify_cmd} %",
    require      => File[ $zrepl::config_dir ],
  }
}
