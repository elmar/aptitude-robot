## Makefile.am
## Process this file with automake to produce Makefile.in
##

bin_SCRIPTS = aptitude-robot
man_MANS    = aptitude-robot.1

CLEANFILES = $(man_MANS)
EXTRA_DIST = aptitude-robot

aptitude-robot.1: aptitude-robot
	pod2man -c 'User Commands' -r "$(VERSION)" $< $@

clean-local:
	rm -f t/t

check-local:
	prove t
