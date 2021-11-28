#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14002.pl
#
#        USAGE: ./14002.pl I J K
#
#  DESCRIPTION: Print the Kth element of the sorted multiplication table
#               of I and J.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/11/21
#===============================================================================

use strict;
use warnings;

my ($i, $j, $k) = @ARGV;
die "$k is greater than $i * $j\n" if $k > $i * $j;

my @prods;
for my $x (1 .. $i) {
	for my $y (1 .. $j) {
		push @prods, $x * $y;
	}
}

@prods = sort { $a <=> $b } @prods;
print $prods[$k - 1] . "\n";
