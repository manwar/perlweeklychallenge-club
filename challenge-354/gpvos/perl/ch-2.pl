#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 11;
use List::MoreUtils qw(natatime);

sub shift_grid {
	my $k = $_[0];
	my @matrix = $_[1]->@*;

	# Matrix may be empty.
	return [ ] if @matrix == 0;

	# All rows must be array refs, but we only care about the first one,
	# which we use to determine the row size ($n);
	# we will assume that all rows have the same size.
	die "shift_grid: argument is not a matrix\n"
		unless ref $matrix[0] eq 'ARRAY' and scalar $matrix[0]->@* > 0;
	my $n = scalar $matrix[0]->@*;

	# Flatten, but only one level deep.
	my @flatmatrix = map { @{$_} } @matrix;

	# Do all shifts at once.
	# There may be more requested shifts than elements;
	# don't shift more elements than are in the array.
	my $totalsize = scalar @flatmatrix;
	$k = $k % $totalsize;
	unshift @flatmatrix, splice @flatmatrix, -$k, $k;

	# Unflatten into rows of size $n.
	my @result;
	my $chopper = natatime $n, @flatmatrix;
	while (my @row = $chopper->()) {
		push @result, [ @row ];
	}
	return [ @result ];
}

is_deeply(shift_grid(1, [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]),
	[ [ 9, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ] ],
	"Example 1");
is_deeply(shift_grid(1, [ [ 10, 20 ], [ 30, 40 ] ]),
	[ [ 40, 10 ], [ 20, 30 ] ],
	"Example 2");
is_deeply(shift_grid(1, [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]),
	[ [ 6, 1 ], [ 2, 3 ], [ 4, 5 ] ],
	"Example 3");
is_deeply(shift_grid(5, [ [ 1, 2, 3 ], [ 4, 5, 6 ] ]),
	[ [ 2, 3, 4 ], [ 5, 6, 1 ] ],
	"Example 4");
is_deeply(shift_grid(1, [ [ 1, 2, 3, 4 ] ]),
	[ [ 4, 1, 2, 3 ] ],
	"Example 5");
# The empty matrix is also a matrix.
is_deeply(shift_grid(8, [ ]), [ ], "Empty matrix");
# The task actually does not specify what kind of elements are in the matrix.
# We can, in fact, handle anything.
is_deeply(shift_grid(3, [ [ 'a', 'b' ], [ 'c', 'd' ] ]),
	[ [ 'b', 'c' ], [ 'd', 'a' ] ],
	"Matrix of strings");
is_deeply(shift_grid(3, [ [ [ 'a' ], [ 'b' ] ], [ [ 'c' ], [ 'd' ] ] ]),
	[ [ [ 'b' ], [ 'c' ] ], [ [ 'd' ], [ 'a' ] ] ],
	"Matrix of array refs");
is_deeply(shift_grid(3, [ [ { 'a' => 1 }, { 'b' => 2 } ],
			  [ { 'c' => 3 }, { 'd' => 4 } ] ]),
	[ [ { 'b' => 2 }, { 'c' => 3 } ],
	  [ { 'd' => 4 }, { 'a' => 1 } ] ],
	"Matrix of hash refs");
is_deeply(shift_grid(5, [ [ 1, undef, 3 ], [ 4, 5, 6 ] ]),
	[ [ undef, 3, 4 ], [ 5, 6, 1 ] ],
	"Example 4 but with an undefined value somewhere");
is_deeply(shift_grid(3, [ [ 'a', [ 'b' ] ],
			  [ { 'c' => 3 }, undef ] ]),
	[ [ [ 'b' ], { 'c' => 3 } ],
	  [ undef, 'a' ] ],
	"Matrix of all kinds of things");
done_testing;

