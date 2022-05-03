#!/usr/bin/env perl
use strict;
use warnings;
use List::Util 'sum';

# You are given a list of positive numbers, @n.

# Write a script to find out the summations as described below.

# Example 1
# Input: @n = (1, 2, 3, 4, 5)
# Output: 42

#     1 2 3  4  5
#       2 5  9 14
#         5 14 28
#           14 42
#              42

# The nth Row starts with the second element of the (n-1)th row.
# The following element is sum of all elements except first element of previous row.
# You stop once you have just one element in the row.
# Example 2
# Input: @n = (1, 3, 5, 7, 9)
# Output: 70

#     1 3  5  7  9
#       3  8 15 24
#          8 23 47
#            23 70
#               70

sub foo {
    my @rows;
    $rows[0] = [@_];

    # we'll keep going as long as we have more than 2 elements left
    while ( @{ $rows[-1] } > 2 ) {
        push @rows, [

            # we always start with the 2nd element of the previous row
            $rows[-1]->[1],

            # each following element is the sum of all numbers from the
            # 2nd element until the position (not index, but position in 
            # the tabular view above) we are currently filling, of
            # the previous row.
            map { sum @{ $rows[-1] }[ 1 .. $_ ] } 2 .. $#{ $rows[-1] }
        ];
    }

    # We're supposed to stop and return when we only have one element left,
    # but it is actually easier to stop at two elements left. The last row
    # is just the 2nd element of the row before, so we can return that directly.
    return $rows[-1]->[-1];
}

use Test::More;

is foo( 1, 2, 3, 4, 5 ), 42;
is foo( 1, 3, 5, 7, 9 ), 70;

done_testing;
