facter-updates
==============
Custom [Facter Facts](http://puppetlabs.com/puppet/related-projects/facter/) for counting the number of package updates a system has pending. Based off the [Byobu](http://byobu.co/) updates status module.

Currently supports:
* Archlinux (pacman)
* Debian, Ubuntu and derived systems (apt-get or update-notifier)
* Mac OS X (tested on 10.8)
* Red Hat Enterprise Linux, CentOS, Scientific Linux and other yum-based distros (tested on RHEL 6)
* SuSE (zypper)
* Windows (tested on Windows 2008R2)

Facts provided:
* updates: the total number of updates pending
* updates\_security: total number of security updates pending (not available on all operating systems)

TODO
----
* add support for other systems
* updates\_security facts for more systems
* cache results
