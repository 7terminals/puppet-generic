# Define: generic::timezone
#
# This file provides definition generic::timezone
#
# Parameters:
#	zonefile - Path of time zone file. Usually /usr/share/zoneinfo/America/<location>
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
#		zonefile => "/usr/share/zoneinfo/America/New_York",
#	}
#
# [Remember: No empty lines between comments and class definition]
define generic::timezone ($zonefile) {
	file {
		"/etc/timezone" :
			ensure => link,
			target => $zonefile,
			owner => root,
			group => root,
	}
}