#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
302-2: Step by Step     Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step sum is never less than one.

Example 1
Input: @ints = (-3, 2, -3, 4, 2)
Output: 5

For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7
Example 2
Input: @ints = (1, 2)
Output: 1
Example 3
Input: @ints = (1, -2, -3)
Output: 5
=end comment

my @Test =
    [-3, 2, -3, 4, 2],  5, 
    [1, 2],             1, 
    [1, -2, -3],        5, 
    [0,],               1,
    [1,],               1,
    [-1,],              2,
    [1,1,-1,2,-2],      1,
    [1,1,-1,1,-3],      2,
    [],                 Int,
;
plan @Test ÷ 2;

multi task( [] )         { Int }
multi task( @a is copy --> Int) {
    for 1..@a -> \i { @a[i] += @a[i-1] }
    my $low = min @a; 
    if $low < 1 { return $low.abs + 1 }
    return 1;
}

for @Test -> @in, $exp {
    is task(@in), $exp, ($exp//"Int") ~ " <- @in.raku()";
}
done-testing;

my @int = 1,1,1,-3,-2;
say "\nInput: @int = @int.raku()\nOutput: { task @int }";
