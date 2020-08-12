#!/usr/bin/perl

use Test2::V0;
use List::Util 'min';

# first arg: window size
# remaining args: input array
sub sliding_min {
	my $S = shift;
	
	# Take the minimum of a sliding window
	map min(@_[$_ .. $_ + $S - 1]), 0 .. $#_ - $S + 1;
}

is [sliding_min 3, (1, 5, 0, 2, 9, 3, 7, 6, 4, 8)],
	[0, 0, 0, 2, 3, 3, 4, 4], 'example from challenge';

done_testing;
