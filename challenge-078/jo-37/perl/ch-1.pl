#!/usr/bin/perl

use Test2::V0;
use List::Util 'reduce';

# Viewing at the array from right to left.  Every element that is larger
# than the current first leading element is leading too and is prepended
# to the list.  Appending (0) to an empty list as requested, though this
# leads to ambiguous results.
sub leading {
	(@{(reduce {
		unshift @$a, $b if $b > ($a->[0] // '-inf');
		$a;
	} [], reverse @_)}, (0) x !@_) ;
}

is [leading 9, 10, 7, 5, 6, 1], [10, 7, 6, 1], 'first example'; 
is [leading 3, 4, 5], [5], 'second example';
is [leading], [0], 'no leader';
is [leading -1, 0], [0], 'ambiguous result';

done_testing;
