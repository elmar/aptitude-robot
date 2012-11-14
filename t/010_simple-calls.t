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

# non-config-dir: /dev/null
$aptitude_command = Aptitude::Robot::Command->new(config_dir => '/dev/null');
is( ref $aptitude_command, 'Aptitude::Robot::Command',
    'generate new object');
is_deeply( [ $aptitude_command->command() ], [],
    'non-directory config dir should give empty command array');
is( $aptitude_command->error_msg(), 'Error: /dev/null is not a aptitude-robot config directory',
    'check for error string');

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/empty-config"
);
is( ref $aptitude_command, 'Aptitude::Robot::Command',
    'generate new object');
is_deeply( [ $aptitude_command->command() ], ['aptitude', '-y', 'install' ,'~U !~ahold'],
    'empty config dir should result in `aptitude -y install ~U !~ahold`' );
is( $aptitude_command->error_msg(), '', 'no error reported' );

done_testing();
