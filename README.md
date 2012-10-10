Aptitude Robot
==============

Automate package choice management

## Introduction

On an individual Debian host it is most convenient to select packages for
installation and removal within the interactive mode of aptitude.  If you do
the same for several machines the task becomes repetitive.  If you like to
maintain certain standard package choices across those machines this is not
only tedious but error prone.

The solution is to write some scripts that automate the installation/removal of
packages.  Either apt-get or the command line interface of aptitude allow you
to do this.  <code>aptitude-robot</code> is a thin layer that reads in some
configuration files and calls aptitude via the command line interface with the
appropriate parameters.  The configuration files allow you to separate out
common packages from host specific ones.  This way you can keep the list
packages simple to read rather than having to write custom versions of the
script for each host.

## Installation

The simplest way to install is via a Debian package

    aptitude install aptitude-robot

This works when <code>aptitude-robot</code> is available for your version in
one of the repositories (you may need to check out the backports).  If it is
not in one of the repositories you use or if you want to install a newer
version follow the instructions below on how to [build from
source](#building-from-source).

## Configuration

With the exception of <code>/etc/default/aptitude-robot</code> the
configuration files are in the directory <code>/etc/aptitude-robot</code>.

### Package Lists

In <code>/etc/aptitude-robot/pkglist.d/</code> you can add one or more package
lists.  Their names should conform to the run-parts(8) conventions (like a dot
in the file name will disable it).  These files should contain one package name
per line preceded by an action you want to perform with this package.  The
actions are specified with the characters used by aptitude, i.e.,
<code>+</code> for install, <code>-</code> for removal, etc.  Read the
aptitude(8) man page under "override specifier" for a complete list.  Comments
starting with <code>#</code> are allowed.

If you have more than one package list file the are concatenated (according to
run-parts(8)).  If a package appears more than once the last action mentioned
applies.

Example

    #example: /etc/aptitude-robot/10_mypackages
    + less
    + htop
    + build-essential
    - ppp

If you install additional packages via aptitude-robot it is up to you to set up
the configuration for those packages beforehand.  If you call
<code>aptitude-robot</code> on the command line it will ask for missing
configuration information the same way aptitude would.  The automatic
invocations of <code>aptitude-robot</code> by cron or init try to always choose
the default configuration non-interactively.  Make sure you provide the
appropriate configuration files and debconf preseeds for the packages you
intend to install.

### Options

In the file <code>/etc/aptitude-robot/options</code> you can specify additional options for aptitude.  List one option per line.  Typical options might be:

    --without-recommends
    --add-user-tag-to "aptitude-robot,?action(install)"

### Triggers

The directories <code>/etc/aptitude-robot/triggers.pre</code> and
<code>/etc/aptitude-robot/triggers.post</code> may contain scripts that will be
run by aptitude-robot before and after aptitude, respectively.  They are run by
<code>run-parts(8)</code>.

By default there are no trigger scripts.  Be careful placing scripts in these
directories as they are always run unconditionally of the actions that aptitude
may or may not perform.  For scripts that should only run upon installation,
removal, or upgrade of a specific package the relevant preinst, postinst, etc.
scripts of the package would be the right place.

### Cron and Init Defaults

In <code>/etc/default/aptitude-robot</code> you can control the execution of
aptitude-robot by setting some variables.

* *RUN_DAILY*   if set to "no", aptitude-robot will not run via the daily cron
* *RUN_ON_BOOT* if set to "no", aptitude-robot will not run at boot time
* *LOG_SESSION* specify an alternative location for the (temporary) session log
* *LOGFILE*     specify the file where the logs are accumulated
* *MAIL_TO*     (optional) mail address where the session log is sent to

## Running and Deployment

Out of the box aptitude-robot will run daily and at each boot.  You can call
<code>aptitude-robot</code> manually whenever you need.

If you want to run <code>aptitude-robot</code> periodically more often than
daily you can write your own crontab entry, e.g., in
<code>/etc/cron.d/aptitude-robot</code>.  You may then want to disable the
daily cron jobs by setting <code>RUN_DAILY=no</code> in
<code>/etc/default/aptitude-robot</code>.

## Scenarios

### Server with Mostly Unattended Upgrades

By default aptitude-robot will upgrade all packages daily.  On a server you
want to have security upgrades deployed as soon as possible but for some
critical packages you want to test them first with your configuration before
installing an upgrade.  With aptitude-robot you can choose to keep some
packages while automatically upgrading all the others.  E.g., on a web server
with a complex configuration you may add a package list in
<code>/etc/aptitude-robots/pkglist.d/90_keep_web</code> with the contents:

    : apache2
    : apache2-mpm-prefork
    : apache2-utils
    : apache2.2-bin
    : apache2.2-common
    : libapache2-mod-php5

You can then concentrate on the security announcement for apache and its
plugins.  All other security announcement you can read at you leisure for
educational purposes only.

### Standardized Deployments

On a development host you can build up and test package lists.  You can then
use these lists to deploy (and maintain) hosts with a standard set of packages.
By splitting up the package list into several file according to usage patterns
you can arrange for optional installs too.

If you want to prevent automatic upgrade of certain packages but have them
still installed on initial deployment you can specify both actions, as follows:

    + foo
    : foo

During the initial deployment you would run <code>aptitude-robot</code> with
the <code>--force-install</code> option to ignore the keep action.

## Building from Source

You can build <code>aptitude-robot</code> from the GIT repository as follows:

    sudo aptitude -y install autoconf autotools-dev build-essential git
    sudo aptitude -y install libany-moose-perl libfile-slurp-perl perl-doc
    git clone https://github.com/elmar/aptitude-robot.git
    cd aptitude-robot
    autoreconf --force --install
    ./configure
    make dist
    mv *.tar.gz ../`echo *.tar.gz | sed -e 's/robot-/robot_/' -e 's/\.tar/.orig.tar/'`
    make distclean
    debuild -uc -us
    debclean
    cd ..
    ls -l *.deb

This will generate a Debian package that you can install with dpkg

    sudo dpkg -i *.deb
