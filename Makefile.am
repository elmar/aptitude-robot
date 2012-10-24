## Makefile.am
## Process this file with automake to produce Makefile.in
##

dist_sbin_SCRIPTS    = aptitude-robot
dist_pkgdata_SCRIPTS = aptitude-robot-session random-delay
man_MANS             = aptitude-robot.1

pkgconfdir             = $(sysconfdir)/aptitude-robot
pkglistdir             = $(pkgconfdir)/pkglist.d
triggerspredir         = $(pkgconfdir)/triggers.pre
triggerspostdir        = $(pkgconfdir)/triggers.post
dist_pkgconf_DATA      = etc/aptitude-robot/options
dist_pkglist_DATA      = etc/aptitude-robot/pkglist.d/README.txt
dist_triggerspre_DATA  = etc/aptitude-robot/triggers.pre/README.txt
dist_triggerspost_DATA = etc/aptitude-robot/triggers.post/README.txt

CLEANFILES = $(man_MANS)
EXTRA_DIST = README.mdown TODO.mdown t

aptitude-robot.1: aptitude-robot
	pod2man -c 'User Commands' -r "$(VERSION)" $< $@

check-local:
	TOPDIR=$(abs_top_srcdir) prove -I$(abs_top_srcdir) $(abs_top_srcdir)/t
