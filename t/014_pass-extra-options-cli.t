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

use IPC::Run qw( run );

my $in = '';
my $out;
my $err;
my $cmd;

$cmd = [
    $arcmd,
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
    '--foobar',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'simulate switch'
);

is( $out, "'aptitude' '--foobar' 'full-upgrade' '~U !~ahold'\n",
    'command line should pass through arbitrary extra options');

done_testing();
