#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16302.pl
#
#        USAGE: ./16302.pl N [ N ] ...
#
#  DESCRIPTION: Summations of positive integers 
#               The nth Row starts with the second element of the (n-1)th row.
#               The following element is sum of all elements except first element of previous row.
#               You stop once you have just one element in the row.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/05/22
#===============================================================================

use strict;
use warnings;

my @z = grep { /^[1-9][0-9]*$/ } @ARGV;

while (1 < @z) {
	my @y   = $z[1];
	my $tot = $z[1];
	for my $n (2 .. $#z) {
		$tot += $z[$n];
		push @y, $tot;
	}
	@z = @y;
}

print "@z\n";

