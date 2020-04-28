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

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/empty-config");
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', 'full-upgrade', '~U !~ahold'],
    'empty config dir should result in empty file list'
);

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/single-file");
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', 'full-upgrade', '~U !~ahold', 'bar-', 'foo+'],
    'single file case',
);

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/multiple-files");
is_deeply(
    [ $aptitude_command->command() ],
    ['aptitude', 'full-upgrade', '~U !~ahold', 'bar-', 'fnord=', 'foo-', 'quux:'],
    'multiple file case',
);
done_testing();
