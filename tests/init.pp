generic::localuser { 'jude':
  comment                 => "jude's account on the local system",
  ensure                  => 'present',
  uid                     => '7001',
  gid                     => '7001',
  groups                  => ['wheel', 'jude'],
  home                    => '/home/jude',
  managehome              => true,
  password                => "encrypted password",
  shell                   => '/bin/bash',
  system                  => false,
  ssh_authorized_key      => "long_ssh_public_key",
  ssh_authorized_key_type => 'ssh-rsa',
  allowdupe               => false,
  expiry                  => "2015-10-28"
}

#generic::domUwallclock { 'domUwallclock':
#  ensure => 'present',
#}

generic::timezone { 'Calcutta':
  zone => 'Asia/Calcutta',
}