#!/usr/bin/perl

use PDL;
# avoid conflicting import
use Test2::V0 '!float';

sub multi_rotate {
	# convert 1st arg to a piddle
	my $a = long(shift);
	# 2nd arg: pack the array elements into arrays of length one.
	my $b = [map [$_], @{(shift)}];

	# The range method returns rectangular parts of the input piddle
	# starting at the given positions.  With the full length of $a as
	# the parts' length and periodic boundary conditions it actually
	# performs multiple rotations just as required by this task.  The
	# source dimension needs to be moved to the front.
	$a->range($b, $a->dim(0), 'periodic')->reorder(1, 0)->unpdl;
}

is multi_rotate([10, 20, 30, 40, 50], [3, 4]),
	[[40, 50, 10, 20, 30], [50, 10, 20, 30, 40]], 'first example';
is multi_rotate([7, 4, 2, 6, 3], [1, 3, 4]),
	[[4, 2, 6, 3, 7], [6, 3, 7, 4, 2], [3, 7, 4, 2, 6]], 'second example';

done_testing;
