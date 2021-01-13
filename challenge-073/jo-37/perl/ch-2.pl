#!/usr/bin/perl

use Test2::V0;
use List::Util 'min';

sub left_min {
	# For all array elements:
	# Take the array slice "left" of the element,
	# filter for elements smaller than the selected, 
	# take the mininum of those
	# and set the result to zero if there was nothing to minimize.
	map {my $e = $_[$_]; min(grep {$_ < $e} @_[0 .. $_-1]) // 0} 0 .. $#_;
}

is [left_min 7, 8, 3, 12, 10], [0, 7, 0, 3, 3], 'first example';
is [left_min 4, 6, 5], [0, 4, 4], 'second example';

done_testing;
