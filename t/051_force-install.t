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

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/force-install-1",
    force_install => 1,
);
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', '-y', 'install', '~U', 'bar-', 'baz:', 'foo+', 'quux='],
    'with force-install + and - override : and/or ='
);

done_testing();
