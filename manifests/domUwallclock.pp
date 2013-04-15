# Define: generic::domUwallclock
#
# This file provides definition generic::domUwallclock
define generic::domUwallclock ($ensure = 'present') {
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
    if ($::virtual == 'xenu') {
      file { '/proc/sys/xen/independent_wallclock':
        content => '1',
      }

      exec { 'echo "independent_wallclock=1" >> /etc/sysctl.conf':
        unless => 'grep -q independent_wallclock=1 /etc/sysctl.conf '
      }
    } else {
      notify { 'Not a Xen domU.':
      }
    }
  }
}