#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
Edited for space.
338-1: Highest Row      Submitted by: Mohammad Sajid Anwar

You are given a m x n matrix.
Write a script to find the highest row sum in the given matrix.

Example 1
Input: @matrix = ([4,  4, 4, 4],
                  [10, 0, 0, 0],
                  [2,  2, 2, 9])
Output: 16

Row 1: 4  + 4 + 4 + 4 => 16
Row 2: 10 + 0 + 0 + 0 => 10
Row 3: 2  + 2 + 2 + 9 => 15

Example 2
Input: @matrix = ([1, 5],
                  [7, 3],
                  [3, 5])
Output: 10

Example 3
Input: @matrix = ([1, 2, 3],
                  [3, 2, 1])
Output: 6

Example 4
Input: @matrix = ([2, 8, 7],
                  [7, 1, 3],
                  [1, 9, 5])
Output: 17

Example 5
Input: @matrix = ([10, 20,  30],
                  [5,  5,   5],
                  [0,  100, 0],
                  [25, 25,  25])
Output: 100
=end comment

=begin comment
How are empty rows and undefined elements to be valued?  Here they are ignored.
Empty input dies.
=end comment

my @Test =
    [[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]],                 16,
    [[1, 5], [7, 3], [3, 5]],                                    10,
    [[1, 2, 3], [3, 2, 1]],                                       6,
    [[2, 8, 7], [7, 1, 3], [1, 9, 5]],                           17,
    [[10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]], 100,
    [[ 2,], []],                                                  2,
    [[ -2,], []],                                                -2,
    [[ -2,], [Int,]],                                            -2,
    [[ -2,], [Int, 0]],                                           0,
;

plan 1 + +@Test ÷ 2;

multi task( Empty ) {  die 'Empty input.' }

multi task( @a is copy --> Int) {
    for @a -> @r { @r.=grep( { $_.defined } ); }
    @a.=grep( ? * ) ;
    max @a».sum;
}

dies-ok { task( []) }, "Die <- []";

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}

done-testing;
