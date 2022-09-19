#!/usr/bin/env raku

=begin pod

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #2: Permutation Ranking

    You are given a list of integers with no duplicates, e.g. [0, 1, 2].

    Write two functions, permutation2rank() which will take the list
    and determine its rank (starting at 0) in the set of possible
    permutations arranged in lexicographic order, and rank2permutation()
    which will take the list and a rank number and produce just that
    permutation.

=end pod

use Test;

is permutation2rank([1, 0, 2]),
   [ [0, 1, 2],
     [0, 2, 1],
     [1, 0, 2],
     [1, 2, 0],
     [2, 0, 1],
     [2, 1, 0],
   ];

is rank2permutation([0, 1, 2], 1),
   [0, 2, 1];

done-testing;

#
#
# METHODS

sub permutation2rank($array) {
    return [ $array.sort.permutations ];
}

sub rank2permutation($array, $rank) {
    return @(permutation2rank($array)).[$rank];
}
