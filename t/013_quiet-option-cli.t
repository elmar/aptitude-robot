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
    '--quiet',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'simulate switch'
);

is( $out, "'aptitude' '-y' '-q' 'full-upgrade' '~U !~ahold'\n",
    'command line with --quiet should be `aptitude -y -q full-upgrade ~U !~ahold`');

$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
    '-q',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'simulate switch short option'
);

is( $out, "'aptitude' '-y' '-q' 'full-upgrade' '~U !~ahold'\n",
    'command line with -q should be `aptitude -y -q full-upgrade ~U !~ahold`');

done_testing();
