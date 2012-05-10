#generic

This module manages base services(ntp, sudo, sshd) and provides custom 
resource generic:user
 
 

##Definition: 

generic::user

###Actions:
Creates a user, corresponding group and/or ssh_authorised_key

###Parameters:

	comment					-	A description for the user
	ensure					-	present or absent. Rresent by default
	expiry					-	Expiry date for the user
	gid						-	Primary gid for the user. Should be numeric. Will be automatically created
	groups					-	Additional groups that the user belongs to
	home					-	The home directory for the user
	managehome				-	Whether to manage the home directory when managing the user. Defaults to false. 
								Valid values are true, false
	password				-	The user’s password, in whatever encrypted format the local system requires
	shell					-	The user's login shell
	system					-	Whether the user is a system user, according to the OS’s criteria
	uid						-	The user ID; must be specified numerically.
	ssh_authorized_key		-	User's public key.
	ssh_authorized_key_type	-	User's public key type. Can be ssh-rsa or ssh-dsa. Defaults to ssh-rsa

###Sample Usage:

Create a user, group and/or ssh_authorised_key for the user

	generic::user {	
		'francis':	
		comment => "Franciss account on the local system",
		ensure => 'present',
		uid => '7001',
		gid => '7001',
		groups => 'wheel',
		home => '/home/francis',
		managehome => true,
		password => "encrypted password",
		shell => '/bin/bash',
		system => 'false',
		ssh_authorized_key => "long ssh public key",
		ssh_authorized_key_type => 'ssh-rsa'
	}
	
