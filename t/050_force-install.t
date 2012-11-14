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

ok( $aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/empty-config",
), 'Aptitude::Robot::Command->new without the force_install parameter' );
is( $aptitude_command->force_install(), 0, 'force_install parameter should not be set' );

ok( $aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/empty-config",
    force_install => 1,
), 'Aptitude::Robot::Command->new should accept force_install parameter' );
is( $aptitude_command->force_install(), 1, 'force_install parameter should be set' );
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', '-y', 'install', '~U !~ahold'],
    'even with --force-install the empty config dir should result in empty file list'
);

done_testing();
