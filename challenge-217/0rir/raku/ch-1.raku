#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
217-1: Sorted Matrix            Submitted by: Mohammad S Anwar
Given a n x n matrix where n >= 2, 3rd smallest element in the sorted matrix.

Example 1
Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
Output: 1

The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
The 3rd smallest of the sorted list is 1.
Example 2
Input: @matrix = ([2, 1], [4, 5])
Output: 4

The sorted list of the given matrix: 1, 2, 4, 5.
The 3rd smallest of the sorted list is 4.
Example 3
Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
Output: 0

The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
The 3rd smallest of the sorted list is 0.
=end comment

my @Test =
    ([3, 1, 2], [5, 2, 4], [0, 1, 3]),  ( 0,1,1,2,2,3,3,4,5),
    ([1, 0, 3], [0, 0, 0], [1, 2, 1]),  ( 0,0,0,0,1,1,1,2,3),
    ([2, 1], [4, 5])                 ,  ( 1,2,4,5),
;

plan @Test/2;

sub iron-n-sort( @a -->Array) {
    @a.flat.sort.Array;
}

for @Test -> @in, @exp {
    is iron-n-sort(@in), @exp, "@in[] --> @exp[]";
}
done-testing;

my $matrix = ([2, 1], [4, 5]);
say "\nInput: @matrix = ", $matrix, "\nOutput: ", (iron-n-sort $matrix)[2];
exit;

