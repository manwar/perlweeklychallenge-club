#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
320-2: Sum Difference       Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element sum of the given array.

Example 1
Input: @ints = (1, 23, 4, 5)
Output: 18
…
=end comment

my @Test =
    # in                    exp
    (1, 23, 4, 5),          18,
    (1, 2, 3, 4, 5),         0,
    (1, 2, 34),             27,
    (),                      0,
    (12,),                   9,
;

plan @Test ÷ 2;

sub task( @a) { ( @a.sum - @a.join.comb.sum ).abs }

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @int = 1, 23, 4, 5;

say qq{\nInput: @int = @int.raku()\nOutput: }, task( @int);
