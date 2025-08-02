#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
294-1: Consecutive Sequence         Submitted by: Mohammad Sajid Anwar
You are given an unsorted array of integers, @ints.

Write a script to return the length of the longest consecutive elements sequence. Return -1 if none found. The algorithm must runs in O(n) time.

Example 1
Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4

The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.
Example 2
Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9
Example 3
Input: @ints = (10, 30, 20)
Output: -1
=end comment

my @Test =
    ( 1,0,-1),                          3,
    (-2,-1,-5),                         2,
    (-2,-0,-5),                        -1,
    (2,0,-5),                          -1,
    (10, 4, 20, 1, 3, 2),               4,
    (0, 6, 1, 8, 5, 2, 4, 3, 0, 7),     9,
    (10, 30, 20),                      -1,
    (),                                -1,
    (1,),                              -1,
    (0,1),                              2,
    (1,0),                              2,
    (0,0),                             -1,
    (1,2,3, 5,6),                       3,
    (1,2,3, 5,6,7,8),                   4,
;
plan @Test ÷ 2;

sub task( @in) {
    my ($candi, $best) = 1, 1;
    my @a = @in.sort: +*;
    for 1..^@a -> \i {
        if @a[i-1] == @a[i] - 1 {
            $best max= ++$candi;
        } else {
           $candi = 1; 
        }
   }
   $best = $best > 1 ?? $best !! -1;
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in[]";
}
done-testing;

my @int = 0, 6, 1, 5, 2, 4, 3, 0, 8, 9, 10, 11, 12, 13, 14, 15;

say "\nInput: \@ints = @int.raku()\nOutput: { task @int }";

