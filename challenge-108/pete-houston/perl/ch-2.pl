#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10802.pl
#
#        USAGE: ./10802.pl  
#
#  DESCRIPTION: Bell numbers 0 to 9 via triangle method
#               https://en.wikipedia.org/wiki/Bell_triangle
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/04/21
#===============================================================================

use strict;
use warnings;

my $max = 9;
my @t = ([1]);
for my $x (1 .. $max) {
	my @row = ($t[$x-1]->[-1]);
	for my $i (1 .. $x) {
		push @row, $row[-1] + $t[$x-1]->[$i-1];
	}
	push @t, [@row];
}

print "B_$_ = $t[$_]->[-1]\n" for 0 .. $max;
