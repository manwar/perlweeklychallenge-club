#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';

BEGIN {
	# Piddle holding valid values as a "constant".
	my $valid = sequence(byte, 9) + 1;
	sub VALID () {$valid}
}

# Solver for "beginner sudokus".  Only trivial dependencies will be
# examined.
sub sudoku_beginner {
	# Convert argument to piddle and turn zeroes to BAD, indicating free
	# cells.
	my $s = byte(shift)->setvaltobad(0);

	# Check dimensions and values of input data.
	die "Invalid sudoku\n" unless $s->ndims == 2 &&
		$s->dim(0) == 9 && $s->dim(1) == 9 &&
		all($s->where(isgood $s)->in(VALID));

	say $s;

	# Loop while there are free cells.
	my $bad = nbad $s;
	while ($bad) {
		# Loop over (the coordinates of) all free cells, identified by
		# BAD values.  The "byte" type enforces integer arithmetic,
		# which is needed for the sub square identification.
		#
		# A PDL joke:
		# The dog bites the flat cat, which is bad - and reversed.
		foreach my $free (whichND(isbad $s)->byte->dog) {
			# Determine the set difference between the set of valid
			# values and the concatenation of row, column and sub square
			# values, i.e. find the possible values that are left over
			# for the cell.
			my $left = setops(VALID, 'XOR',
				cat(
					$s->dice_axis(0, $free->at(0))->flat,
					$s->dice_axis(1, $free->at(1))->flat,
					$s->range(($free / 3) * 3, 3)->flat
				)->flat);

			# Fix the cell's value if there is a single value left.
			$s->indexND($free) .= $left->sclr if $left->nelem == 1;
		}
		say $s;

		# Give up if there is no progress.
		(my $prev_bad, $bad) = ($bad, nbad $s);
		die "No straight solution\n" if $bad == $prev_bad;
	}

	$s->unpdl;
}


# main:

# Try to solve the puzzle with a beginners-only algorithm.
# Zeroes represent empty fields.
is sudoku_beginner([
	[0, 0, 0, 2, 6, 0, 7, 0, 1],
	[6, 8, 0, 0, 7, 0, 0, 9, 0],
	[1, 9, 0, 0, 0, 4, 5, 0, 0],
	[8, 2, 0, 1, 0, 0, 0, 4, 0],
	[0, 0, 4, 6, 0, 2, 9, 0, 0],
	[0, 5, 0, 0, 0, 3, 0, 2, 8],
	[0, 0, 9, 3, 0, 0, 0, 7, 4],
	[0, 4, 0, 0, 5, 0, 0, 3, 6],
	[7, 0, 3, 0, 1, 8, 0, 0, 0]]),

	[[4, 3, 5, 2, 6, 9, 7, 8, 1],
	 [6, 8, 2, 5, 7, 1, 4, 9, 3],
	 [1, 9, 7, 8, 3, 4, 5, 6, 2],
	 [8, 2, 6, 1, 9, 5, 3, 4, 7],
	 [3, 7, 4, 6, 8, 2, 9, 1, 5],
	 [9, 5, 1, 7, 4, 3, 6, 2, 8],
	 [5, 1, 9, 3, 2, 6, 8, 7, 4],
	 [2, 4, 8, 9, 5, 7, 1, 3, 6],
	 [7, 6, 3, 4, 1, 8, 2, 5, 9]], 'Example 1';

like dies {sudoku_beginner(zeroes(9, 9))}, qr/^No straight solution$/,
	'no straight solution';
like dies {sudoku_beginner(zeroes(9, 9) + 10)}, qr/^Invalid sudoku$/,
	'invalid values';
like dies {sudoku_beginner(zeroes(9, 9, 9))}, qr/^Invalid sudoku$/,
	'invalid dimensions';

done_testing;
