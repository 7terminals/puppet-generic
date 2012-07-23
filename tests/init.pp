generic::localuser {
	'francis':
	comment => "Francis account on the local system",
	ensure => 'present',
	uid => '7001',
	gid => '7001',
	groups => 'wheel',
	home => '/home/francis',
	managehome => true,
	password => "encrypted password",
	shell => '/bin/bash',
	system => false,
	ssh_authorized_key => "long_ssh_public_key",
	ssh_authorized_key_type => 'ssh-rsa'
}
