#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";

use IPC::Run qw( run );

my $in = '';
my $out;
my $err;
my $cmd;

$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
    '--simulate',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'simulate switch'
);

is( $out, "'aptitude' '-y' '-s' 'install' '~U !~ahold'\n",
    'command line with --simulate should be `aptitude -y -s install ~U !~ahold`');

$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
    '-s',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'simulate switch short option'
);

is( $out, "'aptitude' '-y' '-s' 'install' '~U !~ahold'\n",
    'command line with -s should be `aptitude -y -s install ~U !~ahold`');

done_testing();
