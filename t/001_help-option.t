#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";
my @arcmd       = $ENV{AUTOPKGTEST_TMP} ?
    qw(/usr/sbin/aptitude-robot) :
    (qw(perl), "$topdir/aptitude-robot");

ok( system(@arcmd, '--help') == 0, 'option --help should be allowed' );

done_testing();
