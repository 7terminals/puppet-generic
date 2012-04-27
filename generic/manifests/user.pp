# Class: puppet-generic::user
#
# This module manages puppet-generic::user
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
class puppet-generic::user ($allowdupe,
	$comment,
	$ensure,
	$expiry,
	$gid,
	$groups,
	$home,
	$managehome,
	$name,
	$password,
	$password_max_age,
	$password_min_age,
	$profiles,
	$project,
	$shell,
	$system,
	$uid) {
	user { $name:
		
	}
}
