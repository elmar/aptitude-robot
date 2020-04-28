#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";
my $arcmd       = $ENV{AUTOPKGTEST_TMP} ?
    '/usr/sbin/aptitude-robot' :
    "$topdir/aptitude-robot";

require_ok( $arcmd );

my $aptitude_command;

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/option-with-parameter"
);
is_deeply(
    [ $aptitude_command->options() ],
    [
        '-o', 'Aptitude::Log=/tmp/my-log',
        '-o', 'Aptitude::Foo=bar quux',
        '--display-format', 'foo bar',
    ],
    'options with parameters and spaces'
);

done_testing();
