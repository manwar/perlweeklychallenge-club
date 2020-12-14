#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';

sub count_number {
	# Split the given number into decimal digits and store them in a
	# byte piddle.
	my $n = byte split //, shift;

	# Create a run length encoding for $n.  The piddles $r and $s become
	# filled with the run lengths and the single numbers respectively.
	# The results have the same length as the input piddle and are zero
	# padded.
	$n->rle(my $r = null, my $s = null);

	# Select positive run lengths and the corresponding single numbers,
	# combine these to a matrix (consisting of two lists), transpose it
	# to a list of pairs, flatten the piddle and join the individual
	# elements.
	join '', cat(where $r, $s, $r > 0)->xchg(0, 1)->list;
}

is count_number(1122234), 21321314, 'Example 1';
is count_number(2333445), 12332415, 'Example 2';
is count_number(12345), 1112131415, 'Example 3';
is count_number('2' x 1111),   11112, '"1111" 2';
is count_number(111111111112), 11112, 'eleven 1 one 2';
is count_number(122222222222), 11112, 'one 1 eleven 2';
is count_number('3' x 11121),         111213, '"11121" 3';
is count_number('1' . '3' x 121),     111213, 'one 1 "121" 3';
is count_number('1' x 11 . '3' x 21), 111213, 'eleven 1 twenty-one 3';
is count_number('2' x 111 . '3'),     111213, '"111" 2, one 3';
is count_number(123),                 111213, 'one 1 one 2 one 3';

done_testing;
