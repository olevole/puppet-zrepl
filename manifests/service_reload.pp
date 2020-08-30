# @summary
#   This class implements zrepl service reload without
#   restarting the whole service when a config changes
# @api private
class zrepl::service_reload () {
  if $zrepl::server::manage_service == true {
    $init_selector = $zrepl::run_service::init_selector

    $zrepl_reload = $zrepl::init_style ? {
      'systemd'                     => "systemctl reload-or-restart ${init_selector}",
      /^(upstart|none)$/            => "service ${init_selector} reload",
      /^(sysv|redhat|sles|debian)$/ => "/etc/init.d/${init_selector} reload",
      'launchd'                     => "launchctl stop ${init_selector} && launchctl start ${init_selector}",
    }

    exec { 'zrepl-reload':
      command     => $zrepl_reload,
      path        => ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin', '/usr/local/sbin'],
      refreshonly => true,
    }
  }
}
