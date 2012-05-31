# Class: generic::timezone
#
# This file provides defination generic::timezone
#
# Parameters:
#	comment					- 	A description for the user
#	ensure					- 	present or absent. Rresent by default
#	gid						- 	Primary gid for the user. Should be numeric. 
#								Will be automatically created
#	groups 					-	Additional groups that the user belongs to
#	home					-	The home directory for the user
#	managehome 				-	Whether to manage the home directory when 
#								managing the user. Defaults to false. 
#								Valid values are true, false
#	password				- 	The user’s password, in whatever encrypted 
#								format the local system requires
#	shell 					- 	The user's login shell
#	system					-	Whether the user is a system user, according to 
#								the OS’s criteria
#	uid						- 	The user ID; must be specified numerically.
#	ssh_authorized_key_type	-	User's public key type. Can be ssh-rsa or 
#								ssh-dsa. Defaults to ssh-rsa
#
# Actions:
# 	Sets the timezone on the server
#
# Requires:
#
# Sample Usage:
# 
#	generic::timezone {
#		'India':
#		zonefile => "/usr/share/zoneinfo/Asia/Kolkata",
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