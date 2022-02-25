#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15301.pl
#
#        USAGE: ./15301.pl  
#
#  DESCRIPTION: Output left factorials of 1 to 10
#
# REQUIREMENTS: Perl 5.10.0 for defined-or and say
#        NOTES: See http://oeis.org/A003422 for left factorials
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/02/22
#===============================================================================

use strict;
use warnings;
use 5.010;

my @fac = 1; # Factorials (0! = 1 by definition)
my @lf;      # Left Factorials

for my $i (1 .. 10) {
	push @fac, $fac[$i-1] * $i;
	push @lf, ($lf[-1] // 0) + $fac[$i-1];
}

say join ', ', @lf;
