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
    "--config-dir=$testdatadir/force-install-1",
    '--force-install',
    '--show-cmdline',
];

ok(
    run( $cmd, \$in, \$out, \$err ),
    'should allow --force-install option on the command line',
);
is(
    $out,
    "'aptitude' 'full-upgrade' '~U !~ahold' 'bar-' 'baz:' 'foo+' 'quux='\n",
    'command line should not show hold and keep entries',
);

done_testing();
