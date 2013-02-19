#!/usr/bin/env perl
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
my $config_dir;

$config_dir = "$testdatadir/triggers-empty";
$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$config_dir",
    '--show-cmdline',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'should run no triggers with empty trigger dirs',
);
is(
    $out,
    "'aptitude' 'full-upgrade' '~U !~ahold'\n",
    'should only show full-upgrade ~U !~ahold with empty trigger dirs',
);

$config_dir = "$testdatadir/triggers";
$cmd = [
    "$topdir/aptitude-robot",
    "--config-dir=$config_dir",
    '--show-cmdline',
];
ok(
    run( $cmd, \$in, \$out, \$err ),
    'should run triggers with trigger dirs',
);
is(
    $out,
    "$config_dir/triggers.pre/10_foo\n"
    . "'aptitude' 'full-upgrade' '~U !~ahold'\n"
    . "$config_dir/triggers.post/10_bar\n",
    'should only show trigger commands',
);

done_testing();
