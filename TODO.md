# TODO

* catch error cases in pkglist.d files
* create Debian package
  * including a typical cron job
  * empty package list (i.e. full-upgrade as default)

* maybe generate a package list from an installed system

* possibly sleep for a random number of seconds in cron.daily
  this may spread the load between multiple hosts all running
  aptitude-robot at the same time

* deal with non-interactive configuration of packages
  i.e., set options so that debconf does not call dialog

* aptitude clean at the end of aptitude-robot-session with a
  flag to switch this off

* logrotate for /var/log/aptitude-robot
