# Define: generic::domUwallclock
#
# This file provides definition generic::domUwallclock
define generic::domUwallclock {
	if ($::virtual == 'xenu') {
		file {
			'/proc/sys/xen/independent_wallclock' :
				content => '1',
		}
		exec {
			'echo "independent_wallclock=1" >> /etc/sysctl.conf' :
				unless => 'grep -q independent_wallclock=1 /etc/sysctl.conf '
		}
	}
	else {
		notify {
			'Not a Xen domU.':
		}
	}
} 