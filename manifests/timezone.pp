# Define: generic::timezone
#
# This file provides definition generic::timezone
#
# Parameters:
#	zone - Path of time zone file relative to /usr/share/zoneinfo/ eg 'America/New_York'
#
# Actions:
# 	Sets the timezone on the server
#
# Requires:
#
# Sample Usage:
# 
#	generic::timezone {
#		'New_York':
#		zone => 'America/New_York',
#	}
#
# [Remember: No empty lines between comments and class definition]
define generic::timezone ($zone) {
	case $::operatingsystem {
		debian, ubuntu, centos, redhat, oel, linux, fedora, Amazon : {
			$supported = true
		}
		default : {
			$supported = false
			notify {
				"${module_name}::timezone_unsupported" :
					message =>
					"The ${module_name}::timezone resource defination is not supported on ${::operatingsystem}",
			}
		}
	}
	if ($supported == true) {
		file {
			'/etc/timezone' :
				ensure => present,
				content => $zone,
				owner => root,
				group => root,
		}
		file {
			'/etc/localtime' :
				ensure => link,
				target => "/usr/share/zoneinfo/${zone}",
				owner => root,
				group => root,
		}
	}
} 