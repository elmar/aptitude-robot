#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
use File::Temp qw(tempfile);
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";
my $rph         = $ENV{AUTOPKGTEST_TMP} ?
    '/usr/share/aptitude-robot/reporting-helpers' : './reporting-helpers';
my $test_message = <<EOT;
Setting up grub-efi-amd64 (2.02+dfsg1-20+deb10u2) ...
Installing for x86_64-efi platform.
Installation finished. No error reported.
Generating grub configuration file ...
Redundant argument in sprintf at /usr/share/perl5/Debconf/Element/Noninteractive/Error.pm line 54,  line 9.
Get:1 https://debian.ethz.ch/debian buster/main amd64 libgpg-error-dev amd64 1.35-1 [124 kB]
Get:2 https://debian.ethz.ch/debian buster/main amd64 libgpg-error-l10n all 1.35-1 [97.6 kB]
Get:3 https://debian.ethz.ch/debian buster/main amd64 libgpg-error-mingw-w64-dev all 1.35-1 [685 kB]
EOT
my ($fh, $filename) = tempfile();
print $fh $test_message;

is( `sh -c ". $rph; errors_in_logfile $filename"`, '',
    'errors_in_logfile() reports no error on false positives' );
unlike( `sh -c ". $rph; print_logfile_for_xymon $filename"`, qr/\&(yellow|red)/,
    'print_logfile_for_xymon() does not mark false positives' );

done_testing();
