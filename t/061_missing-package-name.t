#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use Test::Warnings qw(:all);
use Test::Deep qw(cmp_deeply re);
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";
my $arcmd       = $ENV{AUTOPKGTEST_TMP} ?
    '/usr/sbin/aptitude-robot' :
    "$topdir/aptitude-robot";

require_ok( $arcmd );

my $aptitude_command;
my @aptitude_command;

$aptitude_command = Aptitude::Robot::Command->new(config_dir => "$testdatadir/missing-package-name");

cmp_deeply(
    [ warnings { @aptitude_command = $aptitude_command->command() } ],
    [
     re("Missing package name in line '\\+' somewhere under .*/testdata/missing-package-name/pkglist.d/. Ignoring this line.\n"),
     re("Missing package name in line '-' somewhere under .*/testdata/missing-package-name/pkglist.d/. Ignoring this line.\n"),
     re("Missing package name in line '_' somewhere under .*/testdata/missing-package-name/pkglist.d/. Ignoring this line.\n"),
    ],
    'Warnings about missing package have been emitted'
);
is_deeply(
    [ @aptitude_command ],
    ['aptitude', 'full-upgrade', '~U !~ahold', 'bar-', 'foo+'],
    'missing package name case',
);
done_testing();
