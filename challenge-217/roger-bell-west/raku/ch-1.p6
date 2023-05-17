#! /usr/bin/raku

use Test;

plan 3;

is(sortedmatrix([[3, 1, 2], [5, 2, 4], [0, 1, 3]]), 1, 'example 1');
is(sortedmatrix([[2, 1], [4, 5]]), 4, 'example 2');
is(sortedmatrix([[1, 0, 3], [0, 0, 0], [1, 2, 1]]), 0, 'example 3');

sub sortedmatrix(@matrix) {
    my @n = @matrix[*;*];
    return @n.sort({$^a <=> $^b})[2];
}
