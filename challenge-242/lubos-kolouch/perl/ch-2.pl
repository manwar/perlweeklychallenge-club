use strict;
use warnings;
use Test::More tests => 2;

sub flip_matrix {
    my @matrix = @_;
    return map { [ map { 1 - $_ } reverse @$_ ] } @matrix;
}

# Test cases with the correct structure
is_deeply([flip_matrix([1, 1, 0], [1, 0, 1], [0, 0, 0])], [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'Example 1');
is_deeply([flip_matrix([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])], [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], 'Example 2');
