# Define: generic::localuser
#
# TThis file provides definition generic::localuser
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
# 	Creates a user, group and/or ssh_authorised_key for the user
#
# Requires:
#
# Sample Usage:
# 
#	generic::localuser {
#		'francis':
#		comment => "Franciss account on the local system",
#		ensure => 'present',
#		uid => '7001',
#		gid => '7001',
#		groups => 'wheel',
#		home => '/home/francis',
#		managehome => true,
#		password => "encrypted password",
#		shell => '/bin/bash',
#		system => 'false',
#		ssh_authorized_key_type => 'ssh-rsa'
#	}
#
# [Remember: No empty lines between comments and class definition]
define generic::localuser ($allowdupe = undef,
	$comment = undef,
	$ensure = 'present',
	$expiry = undef,
	$gid = undef,
	$groups = undef,
	$home = "/home/$name",
	$managehome = false,
	$password = undef,
	$shell = '/bin/bash',
	$system = false,
	$uid = undef,
	$ssh_authorized_key = undef,
	$ssh_authorized_key_type = 'ssh-rsa') {
	case $::operatingsystem {
		debian, ubuntu : {
			$supported = true
		}
		centos, redhat, oel, linux : {
			$supported = true
		}
		default : {
			$supported = false
			notify {
				"${module_name}_unsupported" :
					message =>
					"The ${module_name} module is not supported on ${::operatingsystem}",
			}
		}
	}
	if ($supported == true) {
		if ($ensure == 'present') {
			group {
				$name :
					name => $name,
					ensure => present,
					gid => $gid,
					allowdupe => $allowdupe,
			}
			user {
				$name :
					name => $name,
					ensure => present,
					comment => $comment,
					expiry => $expiry,
					gid => $gid,
					groups => $groups,
					home => $home,
					managehome => $managehome,
					password => $password,
					shell => $shell,
					system => $system,
					uid => $uid,
					require => Group[$name],
			}
			if ($ssh_authorized_key != undef) {
				ssh_authorized_key {
					$name :
						name => $name,
						ensure => present,
						key => $ssh_authorized_key,
						type => $ssh_authorized_key_type,
						user => $name,
						require => User[$name],
				}
			}
		}
		elsif ($ensure == 'absent') {
			if ($ssh_authorized_key != undef) {
				ssh_authorized_key {
					$name :
						name => $name,
						ensure => absent,
						user => $name,
				}
				user {
					$name :
						name => $name,
						ensure => absent,
						require => Ssh_authorized_key[$name],
				}
				group {
					$name :
						name => $name,
						ensure => absent,
						require => User[$name]
				}
			}
			else {
				user {
					$name :
						name => $name,
						ensure => absent,
				}
				group {
					$name :
						name => $name,
						ensure => absent,
						require => User[$name]
				}
			}
		}
		else {
			notify {
				"${module_name}_error" :
					message =>
					"Attribute ensure is required and  must ether 'absent' or 'present''",
			}
		}
	}
}
