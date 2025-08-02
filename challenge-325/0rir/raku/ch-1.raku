#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Consecutive One         Submitted by: Mohammad Sajid Anwar

You are given a binary array containing only 0 or/and 1.
Write a script to find out the maximum consecutive 1 in the given array.


Example 1
Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

Example 2
Input: @binary = (0, 0, 0, 0)
Output: 0

Example 3
Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2
=end comment

my @Test =
    # in                    exp
    (0, 1, 1, 0, 1, 1, 1),  3,
    (0, 0, 0, 0),           0,
    (1, 0, 1, 0, 1, 1),     2,
    (),                     0,
;
plan +@Test ÷ 2;

sub task( @in) {
    $_ = (  (  (@in.join ~~ m:g/1+/)».Str 
            )».chars
        ).max;
    $_ == -∞ ?? 0 !! $_
}

for @Test -> @in,$exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @binary = 1, 0, 1, 0, 1, 1;
say qq{Input: @binary = @binary.raku()\nOutput: }, task @binary;

