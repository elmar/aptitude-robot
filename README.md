Aptitude Robot
==============

Automate package choice management

## Introduction

On an individual Debian host it is most convenient to select packages for installation and removal within the interactive mode of aptitude.  If you do the same for several machines the task becomes repetitive.  If you like to maintain certain standard package choices across those machines this is not only tedious but error prone.

The solution is to write some scripts that automate the installation/removal of packages.  Either apt-get or the command line interface of aptitude allow you to do this.  <code>aptitude-robot</code> is a thin layer that reads in some configuration files and calls aptitude via the command line interface with the appropriate parameters.  The configuration files allow you to separate out common packages from host specific ones.  This way you can keep the list packages simple to read rather than having to write custom versions of the script for each host.


