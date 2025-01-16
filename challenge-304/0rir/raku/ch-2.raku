#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
304-2: Maximum Average      Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and an integer, $n which is less than or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given integer, $n, and has the maximum average. It should return the average.

Example 1
Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75

Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75
Example 2
Input: @ints = (5), $n = 1
Output: 5
=end comment

my @Test =
    # exp,  size,   input
    12.75,  4,      (1, 12, -5, -6, 50, 3),
    5,      1,      (5,),
;

plan @Test ÷ 3;

sub task( @a, $size where * ≤  @a -->Rat) {
    $size  R÷  max @a.rotor( $size => 1 - $size )».sum;
}

for @Test -> $exp, $size, @in {
    is task( @in, $size), $exp, "$exp <- $size, @in.raku()"
}
done-testing;

my @int = (1, 12, -5, -6, 50, 3, 100, -10, -1, 57);
my $n = 4;
say "\nInput: @int = { @int.raku}\t\$n = $n\nOutput: { task @int, $n }";


