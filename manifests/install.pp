# @summary
#   Install zrepl
class zrepl::install {
  assert_private()

  package { $zrepl::package_name:
    ensure => $zrepl::package_ensure,
    notify => $zrepl::notify_service,
  }
}
