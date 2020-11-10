#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';

# Set to true in order to run additional examples 
my $run_extras = 0;

# Create a piddle holding the corner indices (except the upper left) for
# a 2x2 square and provide it's size.  These could have been defined "by
# hand" as well.
use constant corners => zeros(2, 2)->ndcoords->clump(2,1)->slice('X,1:-1');
use constant c_dim => corners->dim(1);

# Count sub-squares having ones on all four corners.
# Differing from the task's description and as a generalization, any
# non-zero corner values are permitted.  This sub is a verbose demo
# version of the actual implementation.  Set $run_extras to true to
# have this sub called from the tests.
sub count_squares_verbose {
	# Create piddle from input data.
	my $m = pdl(shift);
	say "m: $m";

	# Get the maximum number of sub-squares sharing the same upper left
	# corner.  This is one less than the minimum dimension of $m as the
	# smallest square has size 2x2.
	my $max = $m->shape->min - 1;
	say "max: $max";

	# corners is a pre-calculated constant
	say "corners: ", corners;

	# Uplift corners' dimensions to the maximum number of squares at the
	# same upper left corner.
	my $uplifted_corners = corners->dummy(2, $max);
	say "uplifted_corners: $uplifted_corners";

	# Create a "factor piddle" applicable for $uplifted_corners to
	# generate a sequence of augmenting squares.
	my $factor = sequence($max)->dummy(0)->dummy(1, c_dim) + 1;
	say "factor: $factor";

	# Create a piddle holding all indices of square corners upto the
	# maximum size.  This and the preceeding piddles are all independent
	# from the content of $m.  They depend on the shape of $m only and
	# could have been calculated separately and in advance.
	my $corner_offsets = $uplifted_corners * $factor;
	say "corner_offsets: $corner_offsets";

	# Take all coordinates of non-zero elements of the sub-matrix of $m
	# without the last row and column.  These elements only can be upper
	# left corners of sub-squares.
	my $ul_corner_coords = whichND($m->slice(':-2,:-2'));
	say "ul_corner_coords: $ul_corner_coords";

	# Uplifting $ul_corner_coords' dimensions to the shape of
	# $corner_offsets and adding these offsets results in a piddle
	# holding all corner coordinates (except the upper left) for all
	# sub-squares sharing an upper left corner.  The coordinates contain
	# out-of-bound indices that will be ignored in the next step.
	my $corner_coords =
		$ul_corner_coords->dummy(1, c_dim)->dummy(2, $max)
		+ $corner_offsets;
	say "corner_coords: $corner_coords";

	# Take the values at the calculated corner coordinates within $m,
	# ignoring invalid indices by specifying 'truncate' as boundary
	# condition.
	my $corner_values = $m->indexND($corner_coords, 'truncate');
	say "corner_values: $corner_values";

	# Perform a logical "and" over the values of every square to detect
	# squares having non-zero at all (other) corners.  The value at the
	# upper left corner is non-zero due to the selection of
	# $ul_corner_coords.
	my $all_corners = $corner_values->andover;
	say "all_corners: $all_corners";

	# The sum over $all_corners is the requested number of squares.
	my $count = $all_corners->sum;
	say "count: $count";

	$count;
}

# Actual implementation: A terse form of above sub.
sub count_squares {
	my $m = pdl(shift);
	my $max = $m->shape->min - 1;
	my $corner_offsets = corners->dummy(2, $max)
		* (sequence($max)->dummy(0)->dummy(1, c_dim) + 1);

	$m->indexND(
			whichND($m->slice(':-2,:-2'))->dummy(1, c_dim)->dummy(2, $max)
				+ $corner_offsets,
			'truncate')->andover->sum;
}

SKIP: {
	skip 'intermediate results' unless $run_extras;
	is count_squares_verbose([
		[1, 0, 1, 0],
		[0, 0, 1, 1],
		[1, 0, 1, 1]]), 2, 'show intermediate results';
}

is count_squares([
		[0, 1, 0, 1],
		[0, 0, 1, 0],
		[1, 1, 0, 1],
		[1, 0, 0, 1]]), 1, 'Example 1';

is count_squares([
		[1, 1, 0, 1],
		[1, 1, 0, 0],
		[0, 1, 1, 1],
		[1, 0, 1, 1]]), 4, 'Example 2';

is count_squares([
		[0, 1, 0, 1],
		[1, 0, 1, 0],
		[0, 1, 0, 0],
		[1, 0, 0, 1]]), 0, 'Example 3';

is count_squares([
		[1, 0, 1, 0],
		[0, 0, 1, 1],
		[1, 0, 1, 1]]), 2, 'max and min edge cases on non-square matrix';

SKIP: 
for (32, 512) {
	skip 'large example', 2 unless $run_extras;
	my $X = zeros($_, $_);
	$X->diagonal(0, 1) .= 1;
	$X->slice('-1:0')->diagonal(0, 1) .= 1;
	say "X$_: $X" if $_ < 40;
	is count_squares($X), int($_ / 2), "cross ${_}x${_}";
}

done_testing;

# vi:ts=4:
