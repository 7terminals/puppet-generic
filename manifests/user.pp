# Class: generic::user
#
# This module manages generic::user
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
define generic::user ($allowdupe = undef,
	$comment = undef,
	$ensure = 'present',
	$expiry = undef,
	$gid = undef,
	$groups = undef,
	$home = "/home/$name",
	$managehome = undef,
	$password = undef,
	$password_max_age = undef,
	$password_min_age = undef,
	$shell = undef,
	$system = undef,
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
					password_max_age => $password_max_age,
					password_min_age => $password_min_age,
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
