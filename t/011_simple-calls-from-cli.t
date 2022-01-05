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
    '--config-dir=/dev/null',
    '--show-cmdline',
];
ok(
    not(run( $cmd, \$in, \$out, \$err )),
    'should complain about non-existent config dir'
);

$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$testdatadir/empty-config",
    '--show-cmdline',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'empty config dir should give only `aptitude full-upgrade ~U !~ahold`'
);

is( $out, "'aptitude' 'full-upgrade' '~U !~ahold'\n",
    'command line should be `aptitude full-upgrade ~U !~ahold`');

done_testing();
