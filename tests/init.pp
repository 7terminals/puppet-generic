generic::localuser { 'example.com':
  comment                 => "example.com account on the local system",
  ensure                  => 'present',
  uid                     => '7001',
  gid                     => '7001',
  groups                  => 'wheel',
  home                    => '/home/example.com',
  managehome              => true,
  password                => "encrypted password",
  shell                   => '/bin/bash',
  system                  => false,
  ssh_authorized_key      => "long_ssh_public_key",
  ssh_authorized_key_type => 'ssh-rsa',
  allowdupe               => false,
  expiry                  => "2015-10-28"
}

generic::timezone { 'Calcutta':
  zone => 'Asia/Calcutta',
}