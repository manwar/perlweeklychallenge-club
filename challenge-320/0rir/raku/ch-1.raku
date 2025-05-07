#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
320-Task 1: Maximum Count       Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.


Example 1
Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3

…
=end comment

my @Test =
    # in                        exp
    (-3, -2, -1, 1, 2, 3),      3,
    (-2, -1, 0, 0, 1),          2,
    (1, 2, 3, 4),               4,
    (0,0),                      0,
    (9,),                       1,
    (-9,),                      1,
;
plan @Test ÷ 2;

sub task( @a) { max +@a.grep( * > 0), +@a.grep( * < 0) }

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @int = -3, -2, -1, 1, 2, 3;

say qq{\nInput: @int = @int.raku()\nOutput: }, task @int;
