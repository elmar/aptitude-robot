#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";

require_ok( "$topdir/aptitude-robot" );

my $aptitude_command;

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/extra-space");
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', '-y', 'full-upgrade', '~U !~ahold', 'bar-', 'foo+'],
    'single file case',
);

done_testing();
