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
    config_dir => "$testdatadir/empty-config"
);
is_deeply( [ $aptitude_command->run_parts_lines('pkglist.d') ], [],
    'empty config dir should result in empty lines list' );

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/single-file"
);
is_deeply(
    [ $aptitude_command->run_parts_lines('pkglist.d') ],
    [ '+ foo', '- bar' ],
    'lines for single file case',
);

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/multiple-files"
);
is_deeply(
    [ $aptitude_command->run_parts_lines('pkglist.d') ],
    [
        '+ foo',
        '- bar',
        '= fnord',
        '- foo',
        ': quux',
    ],
    'lines for multiple file case',
);
done_testing();
