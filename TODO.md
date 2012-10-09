# TODO

* catch error cases in pkglist.d files
* create Debian package
  * including a typical cron job
  * empty package list (i.e. full-upgrade as default)

* maybe generate a package list from an installed system

* possibly sleep for a random number of seconds in cron.daily
  this may spread the load between multiple hosts all running
  aptitude-robot at the same time
