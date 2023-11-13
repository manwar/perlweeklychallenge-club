# The Weekly Challenge 242
# Task 2 Flip Matrix
use v5.30.0;
use warnings;

sub fm {
    my @matrix = @_;
    my $n = 1 + $#matrix;
    my $n_matrix = [];
    for my $i (0..$n-1) {
        push $n_matrix->@*, 
          [map {0+!$_} reverse $matrix[$i]->@*];
    }
    return $n_matrix;
}

use Test::More tests=>2;
use Test::Deep;
cmp_deeply fm([1, 1, 0], [1, 0, 1], [0, 0, 0]), 
           [[1, 0, 0], [0, 1, 0], [1, 1, 1]];
cmp_deeply fm([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]),
           [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]];
