#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
276-1 ￼ Complete Day            Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @hours.  Write a script to return
the number of pairs that forms a complete day.  A complete day is defined
as a time duration that is an exact multiple of 24 hours.

Example 1
Input: @hours = (12, 12, 30, 24, 24)
Output: 2

Pair 1: (12, 12)
Pair 2: (24, 24)
Example 2
Input: @hours = (72, 48, 24, 5)
Output: 3

Pair 1: (72, 48)
Pair 2: (72, 24)
Pair 3: (48, 24)
Example 3
Input: @hours = (12, 18, 24)
Output: 0
=end comment

my @Test =
   # exp        in
    Int,        (),
    0,          (1,),
    2,          (12, 12, 24, 24,         30),
    3,          (72, 48, 24,             5),
    0,          (                        72, 5, 3),
    0,          (                        12, 24, 18),
    6,          (12, 12, 12, 12,         24, 7,4,1),
    9,          (2, 2, 2, 2, 0, 24, 24,  7,4,1),
;
plan @Test ÷ 2;

multi task( @a where * !~~ Empty --> Int) {
        @a.classify( * % 24 ).values.map( { $_.elems × $_.end div 2}).sum;
}
multi task( @a --> Int) { Int }

for @Test -> $exp, @in {
    is task(@in), $exp, ($exp // "Int") ~ " <- @in.raku()";
}

done-testing;

my @hour = (12, 12, 12, 12, 36, 60, 0, 24, 24, 48, 7, 4, 1);
say "\nInput: \@hour = @hour[]\nOutput: &task(@hour)";

