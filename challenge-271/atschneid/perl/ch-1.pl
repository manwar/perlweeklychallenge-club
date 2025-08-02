# You are given a m x n binary matrix.

# Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.

# Example 1
# Input: $matrix = [ [0, 1],
#                    [1, 0],
#                  ]
# Output: 1

# Row 1 and Row 2 have the same number of ones, so return row 1.
# Example 2
# Input: $matrix = [ [0, 0, 0],
#                    [1, 0, 1],
#                  ]
# Output: 2

# Row 2 has the maximum ones, so return row 2.
# Example 3
# Input: $matrix = [ [0, 0],
#                    [1, 1],
#                    [0, 0],
#                  ]
# Output: 2

# Row 2 have the maximum ones, so return row 2.

use strict;
use warnings;

use v5.38;

use List::Util qw( reduce );

my @examples = (
    [ [0, 1],
      [1, 0] ],
    [ [0, 0, 0],
      [1, 0, 1] ],
    [ [0, 0],
      [1, 1],
      [0, 0] ]
    );

for (@examples) {
    my @derefed_matrix = @$_;
    say( show_matrix( @derefed_matrix ) );

    my $max_row = find_max_earliest_sum( @derefed_matrix );

    # very non-perlishly 1 indexed!?
    ++$max_row;

    say("max row :: $max_row");
}

sub show_matrix (@matrix) {
    return join ",\n",
	map { join ' ', '[', ( join ', ', $_->@* ), ']' } @matrix;
}

sub find_max_earliest_sum ( @matrix ) {
    # map each row of the matrix to the sum of its elements
    my @counts = map { reduce {$a + $b} 0, $_->@* } @matrix;

    # iterate of indices and find the first index of the max element
    my $idx = 0;
    for (0..scalar(@counts) - 1) {
	if ($counts[$_] > $counts[$idx]) {
	    $idx = $_;
	}
    }

    return $idx;
}
