#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";

ok( system('perl', "$topdir/aptitude-robot", '--help') == 0,
    'option --help should be allowed' );

done_testing();
