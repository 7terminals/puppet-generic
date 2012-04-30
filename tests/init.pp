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
