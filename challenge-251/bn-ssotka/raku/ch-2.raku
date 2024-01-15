#!/usr/bin/env raku

# You are given a m x n matrix of distinct numbers.

# Write a script to return the lucky number, if there is one, or -1 if not.

# A lucky number is an element of the matrix such that it is
# the minimum element in its row and maximum in its column.

sub get-lucky (@matrix) {
    my @row_mins = @matrix.map: *.min; # get the mins of each row
    my @rotated_matrix = [Z] @matrix;  # rotate the matrix
    my @col_maxs = @rotated_matrix.map: *.max; # get the max of each of the rotated rows

    my @lucky = @row_mins ∩ @col_maxs; # get the intersection of the two
    return @lucky ?? @lucky[0] !! -1;
}
my @test-matricies = (
    (
        [ 3,  7,  8],
        [ 9, 11, 13],
        [15, 16, 17]
    ),
    (
        [ 1, 10,  4,  2],
        [ 9,  3,  8,  7],
        [15, 16, 17, 12]
    ),
    (
        [7 ,8],
        [1 ,2]
    )
);

for @test-matricies -> @matrix {
    say @matrix;
    say get-lucky(@matrix);
}
