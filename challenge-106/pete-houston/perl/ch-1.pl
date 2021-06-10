#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10601.pl
#
#        USAGE: ./10601.pl N [ N ... ] 
#
#  DESCRIPTION: Output maximum difference between adjacent integers.
#
# REQUIREMENTS: Arguments must all be integers otherwise they will be
#               skipped
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 29/03/21
#===============================================================================

use strict;
use warnings;

my @ints = sort { $a <=> $b } grep { /^-?\d+$/ } @ARGV;
my $max = 0;
for my $i (1 .. $#ints) {
	my $diff = $ints[$i] - $ints[$i - 1];
	$max = $diff if $diff > $max;
}
print "$max\n";
