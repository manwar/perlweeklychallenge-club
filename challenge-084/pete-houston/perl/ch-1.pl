#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8401.pl
#
#        USAGE: ./8401.pl N 
#
#  DESCRIPTION: Reverse a valid 32-bit signed integer N
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/10/20
#===============================================================================

use strict;
use warnings;
use 5.014; # for /a

my $ans    = 0;
my $in     = shift @ARGV;
my $intmax = 2**31 - 1;
my $intmin = -1 - $intmax;

if ($in && $in =~ /^(-?)(\d+)$/a) {
	my $rev = $1 . reverse $2;
	$ans = $rev if ($rev <= $intmax && $rev >= $intmin);
}

printf "%i\n", $ans;
