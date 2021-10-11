#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13301.pl
#
#        USAGE: ./13301.pl N [ N ... ] 
#
#  DESCRIPTION: Print the integer square root(s) of the argument(s)
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/10/21
#===============================================================================

use strict;
use warnings;

while (my $sq = shift) {
	next if $sq =~ /[^0-9]/;
	print "Integer square root of $sq is " . isqrt ($sq) . "\n";
}

# Woo's Abacus method
sub isqrt {
	use integer;
	my $in   = shift;
	my $root = 0;
	my $top  = 1 << 30;
	$top >>= 2 while $top > $in;

	while ($top) {
		if ($in >= $root + $top) {
			$in   -= $root + $top;
			$root += 2 * $top;
		}
		$root /= 2;
		$top  /= 4;
	}
	return $root;
}
