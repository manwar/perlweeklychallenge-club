#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
306-1: Odd Sum          Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers, @ints.
Write a script to return the sum of all possible odd-length subarrays of the given array. A subarray is a contiguous subsequence of the array.

Example 1
Input: @ints = (2, 5, 3, 6, 4)
Output: 77

Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20

Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77
Example 2
Input: @ints = (1, 3)
Output: 4
=end comment

my @Test =
    77,     (2, 5, 3, 6, 4),
     4,     (1, 3),
     4,     (4,),
     0,     (),
;

plan @Test ÷ 2;

multi task( [] ) { 0 }
multi task( @a --> Int) {
    sum do for 1, *+2  …  @a % 2 ?? +@a !! @a -1  {
                @a.rotor($_ => -$_ +1 ).flat.sum;
           }
}

for @Test -> $exp, @in {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()"
}
done-testing;

my @int = (2, 5, 3, 6, 4, 10);
say "\nInput: @int = @int[]\nOutput: ", task( @int);


