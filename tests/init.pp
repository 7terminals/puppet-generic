generic::user {
	"francis" :
		ensure => present,
		uid => 5000,
		gid => 5000,
		ssh_authorized_key=> "alice_in_wonderland",
}
