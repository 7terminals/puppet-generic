# Define: generic::timezone
#
# This file provides definition generic::timezone
#
# Parameters:
# zone - Path of time zone file relative to /usr/share/zoneinfo/ eg 'America/New_York'
#
# Actions:
# 	Sets the timezone on the server
#
# Requires:
#
# Sample Usage:
#
# generic::timezone {
# 	'New_York':
# 	zone => 'America/New_York',
#}
#
# [Remember: No empty lines between comments and class definition]
define generic::timezone ($zone, $ensure = 'present') {
  # we support only Debian and RedHat
  case $::osfamily {
    Debian  : { $supported = true }
    RedHat  : { $supported = true }
    default : { fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
  }

  if !($ensure in ['absent', 'present']) {
    fail('ensure parameter must be either absent or present')
  }

  if ($ensure == 'present') {
    file { '/etc/timezone':
      ensure  => present,
      content => $zone,
      owner   => root,
      group   => root,
    }

    file { '/etc/localtime':
      ensure => link,
      target => "/usr/share/zoneinfo/${zone}",
      owner  => root,
      group  => root,
    }
  }
}
