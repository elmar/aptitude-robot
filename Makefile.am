## Makefile.am
## Process this file with automake to produce Makefile.in
##

dist_sbin_SCRIPTS    = aptitude-robot
dist_sbin_SCRIPTS    += aptitude-robot-session
dist_pkgdata_SCRIPTS = random-delay
dist_pkgdata_SCRIPTS += mail-log-on-error
dist_pkgdata_SCRIPTS += xymon-report
dist_pkgdata_DATA    = reporting-helpers
man_MANS             = aptitude-robot.8 aptitude-robot-session.8

pkgconfdir             = $(sysconfdir)/aptitude-robot
pkglistdir             = $(pkgconfdir)/pkglist.d
optionsdir             = $(pkgconfdir)/options.d
triggerspredir         = $(pkgconfdir)/triggers.pre
triggerspostdir        = $(pkgconfdir)/triggers.post
dist_options_DATA      = etc/aptitude-robot/options.d/10-remove-level-maximum
dist_pkglist_DATA      = etc/aptitude-robot/pkglist.d/README.txt
dist_triggerspre_DATA  = etc/aptitude-robot/triggers.pre/README.txt
dist_triggerspost_DATA = etc/aptitude-robot/triggers.post/README.txt
dist_triggerspost_SCRIPTS = etc/aptitude-robot/triggers.post/90-cleanup.example

CLEANFILES = $(man_MANS)
EXTRA_DIST = README.mdown TODO.mdown build-all t
EXTRA_DIST += aptitude-robot-session.pod LICENSE

aptitude-robot.8: aptitude-robot
	pod2man -s 8 -c 'User Commands' -r "$(VERSION)" $< $@

aptitude-robot-session.8: aptitude-robot-session.pod
	pod2man -s 8 -c 'User Commands' -r "$(VERSION)" $< $@

check-local:
	TOPDIR=$(abs_top_srcdir) prove -I$(abs_top_srcdir) $(abs_top_srcdir)/t
