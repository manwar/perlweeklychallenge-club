#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';
use experimental 'postderef';

{
	# Instructions for the unrolling engine:
	# - edge (as slice arg)
	# - remaining matrix (as slice arg)
	# - affected dimension (row or column)
	# by direction.
	my @instr = (
		['X,(0)', 'X,1:-1', 1],		# first row, east
		['(-1),X', '0:-2,X', 0],	# last column, south
		['-1:0,(-1)', 'X,0:-2', 1],	# last row, west
		['(0),-1:0', '1:-1,X', 0]);	# first column, north

	# Unroll given matrix, i.e. return the elements as a 1-d list in
	# spiral form.
	sub unroll {
		# Input matrix, starting direction and result.
		my ($m, $dir, $unrolled) = (long(shift), 0, PDL->null);

		say $m;
		die "not a matrix" unless $m->ndims == 2;

		while (1) {
			# Get the instructions.
			my ($edge, $remaining, $dim) = $instr[$dir]->@*;

			# Append current edge to the result.
			$unrolled = $unrolled->append($m->slice($edge));

			# Stop if the current edge was the last remaining dimension.
			last if $m->dim($dim) == 1;

			# Take the remaining matrix.
			$m = $m->slice($remaining);

			# Switch direction.
			$dir = ($dir + 1) % 4;
		}

		say $unrolled;
		$unrolled->unpdl;
	}
}

# Test cases by ending direction and number of trailing elements.
is unroll(sequence(long, 3, 3) + 1),
	[1, 2, 3, 6, 9, 8, 7, 4, 5], 'east-1 (Example 1)';

is unroll(sequence(long, 4, 3) + 1),
	[1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7], 'east-2';

is unroll(sequence(long, 3, 4) + 1),
	[1, 2, 3, 6, 9, 12, 11, 10, 7, 4, 5, 8], 'south-1';

is unroll(sequence(long, 3, 5) + 1),
	[1, 2, 3, 6, 9, 12, 15, 14, 13, 10, 7, 4, 5, 8, 11], 'south-2';

is unroll(sequence(long, 4, 4) + 1),
	[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10],
	'west-1 (Example 2)';

is unroll(sequence(long, 5, 4) + 1),
	[1, 2, 3, 4, 5, 10, 15, 20, 19, 18, 17, 16, 11, 6, 7, 8, 9, 14, 13, 12],
	'west-2';

is unroll(sequence(long, 4, 5) + 1),
	[1, 2, 3, 4, 8, 12, 16, 20, 19, 18, 17, 13, 9, 5, 6, 7, 11, 15, 14, 10],
	'north-1';

is unroll(sequence(long, 4, 6) + 1),
	[1, 2, 3, 4, 8, 12, 16, 20, 24, 23, 22, 21, 17, 13, 9,
		5, 6, 7, 11, 15, 19, 18, 14, 10], 'north-2';

# other tests
is unroll([[1, 2], [3, 4]]), [1, 2, 4, 3], 'non-piddle arg';
is unroll([[1, 2]]), [1, 2], 'single row';
is unroll([[1],[2]]), [1, 2], 'single column';
is unroll([[1]]), [1], 'single element';
like dies {unroll [1]}, qr/^not a matrix/, 'not a matrix';

done_testing;
