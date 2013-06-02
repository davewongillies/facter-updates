facter-updates
==============
Facts about the number of package updates a system has pending.

Currently supports:
* Archlinux
* Debian, Ubuntu and derived systems (apt-get or update-notifier)
* Mac OS X (tested on 10.8)
* Red Hat Enterprise Linux/CentOS/Scientific Linux/yum-based distros (tested on RHEL 6)
* SuSE
* Windows (tested on Windows 2008R2)

Facts provided:
* updates: the total number of updates pending
* updates\_security: total number of security updates pending (not available on all operating systems)

TODO
----
* add support for other systems
* updates\_security facts for more systems
* cache results
