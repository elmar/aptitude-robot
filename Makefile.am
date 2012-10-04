## Makefile.am
## Process this file with automake to produce Makefile.in
##

bin_SCRIPTS = aptitude-robot
man_MANS    = aptitude-robot.1

CLEANFILES = $(man_MANS)
EXTRA_DIST = aptitude-robot t/testdata

aptitude-robot.1: aptitude-robot
	pod2man -c 'User Commands' -r "$(VERSION)" $< $@

check-local:
	prove t
