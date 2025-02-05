#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Check Order
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return the indices where it differs from the original array.

Example 1
Input: @ints = (5, 2, 4, 3, 1)
Output: (0, 2, 3, 4)

Before: (5, 2, 4, 3, 1)
After : (1, 2, 3, 4, 5)

Difference at indices: (0, 2, 3, 4)
Example 2
Input: @ints = (1, 2, 1, 1, 3)
Output: (1, 3)

Before: (1, 2, 1, 1, 3)
After : (1, 1, 1, 2, 3)

Difference at indices: (1, 3)
Example 3
Input: @ints = (3, 1, 3, 2, 3)
Output: (0, 1, 3)

Before: (3, 1, 3, 2, 3)
After : (1, 2, 3, 3, 3)

Difference at indices: (0, 1, 3)

=end comment

my @Test =
    (),                 (),
    (1,),               (),
    (1,2),              (),
    (2,1),              (0,1),
    (1, 2, 1, 1, 3),    (1, 3),
    (5, 2, 4, 3, 1),    (0, 2, 3, 4),
    (3, 1, 3, 2, 3),    (0, 1, 3),
    (1, 204, 9, 7, 172, 238, 727, 319, 102), (1, 3, 5, 6, 8),
;
plan @Test ÷ 2;

sub task( @in) {    (@in.sort Z== @in) .grep: !*, :k }

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()"
}
done-testing;

my @int = 1, 204, 9,   7, 172, 238, 727, 102, 319;
print "\nInput: @int = ( ", @int, " )\nOutput: ", task(@int);
