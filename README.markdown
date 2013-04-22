generic
====


Overview
--------

The generic module manages base components(timezone) and provides a resource definition that manages a user, group and/or SSH key. 


Module Description
-------------------

This module manages base components(timezone) and provides a resource definition generic::localuser that manages a user, group and/or ssh_authorised_key. 
This makes managing users via Puppet a lot simpler - one resource for user, group and ssh_authorised_key 

Setup
-----

**What generic affects:**

* Everything related to user management, including groups, SSH keys
* System timezone
	
### Beginning with generic::localhost

Create a user, corresponding group and/or ssh_authorised_key

    generic::localuser { 'example.com':
      comment                 => "example.com's account on the local system",
      ensure                  => 'present',
      uid                     => '7001',
      gid                     => '7001',
      groups                  => ['wheel', 'example.com'],
      home                    => '/home/example.com',
      managehome              => true,
      password                => "encrypted password",
      shell                   => '/bin/bash',
      system                  => false,
      ssh_authorized_key      => "long_ssh_public_key",
      ssh_authorized_key_type => 'ssh-rsa',
      allowdupe               => false,
      expiry                  => "2099-12-1"
    }

### Beginning with generic::timezone

Set the system timezone

    generic::timezone { 'Calcutta':
      zone => 'Asia/Calcutta',
    }

Usage
------

The `generic::localuser` and `generic::timezone` resource definitions have several parameters.

**Parameters within `generic::localuser`**

####`comment`

A description for the user.

####`ensure`

Create or remove the user.
Valid values are present, absent.
Default is present.

####`uid`

The user ID. Must be specified numerically.

####`gid`

The user’s primary group. Must be specified numerically.

####`groups`

The groups to which the user belongs. The primary group should not be listed, and groups should be identified by name rather than by GID. Multiple groups should be specified as an array.

####`home`

The home directory of the user.

####`managehome`

Whether to manage the home directory when managing the user.
Defaults to false. Valid values are true, false.

####`password`

The user's password, in whatever encrypted format the local system requires.

####`shell`

The user's login shell.

####`system`

Whether the user is a system user, according to the OS's criteria.

####`ssh_authorized_key`

User's public key.

####`ssh_authorized_key_type`

User's public key type. Can be ssh-rsa or ssh-dsa.
Defaults to ssh-rsa.

####`allowdupe`

Whether to allow duplicate GIDs.
Defaults to false. Valid values are true, false.

####`expiry`

The expiry date for this user. Must be provided in a zero-padded YYYY-MM-DD format - e.g. 2010-02-19.


**Parameters within `generic::localuser`**

####`timezone`

Name of the time zone.


Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* CentOS 5.9
* CentOS 6.4
* Debian 6.0 
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Bug Reports
-----------

Release Notes
--------------

**0.1.0**

First initial release.
