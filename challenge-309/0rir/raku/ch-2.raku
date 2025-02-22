#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
309-2: Min Diff         Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.

Example 1
Input: @ints = (1, 5, 8, 9)
Output: 1

1, 5 => 5 - 1 => 4
1, 8 => 8 - 1 => 7
1, 9 => 9 - 1 => 8
5, 8 => 8 - 5 => 3
5, 9 => 9 - 5 => 4
8, 9 => 9 - 8 => 1
Example 2
Input: @ints = (9, 4, 1, 7)
Output: 2

9, 4 => 9 - 4 => 5
9, 1 => 9 - 1 => 8
9, 7 => 9 - 7 => 2
4, 1 => 4 - 1 => 3
4, 7 => 7 - 4 => 3
1, 7 => 7 - 1 => 6
=end comment

my @Test =
    # in        exp
    (1, 5, 8, 9), 1,
    (9, 4, 1, 7), 2,
    (9,4),        5,
;
my @Dead =    (),  (10,);
plan @Test ÷ 2 + @Dead;

multi task( @a where +@a ≤  1) { Failure }
multi task( @a --> Int) {
   @a.sort.rotor( 2 => -1).map( { .[1] - .[0] } ).min;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name() } <- @in.raku()";
}
for @Dead -> @in {
    dies-ok { task( @in)}, "Dies @in.raku()";
}


done-testing;

my @int = (1, 5, 8, 9);

say "Input: @int = @int[]\nOutput: {task @int}";

