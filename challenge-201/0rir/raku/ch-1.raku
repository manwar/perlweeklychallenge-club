#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
201-1: Missing Numbers          Submitted by: Mohammad S Anwar
Given an array of unique numbers, find all missing numbers in the
range 0..$n where $n is the array size.

Example 1
Input: @array = (0,1,3)
Output: 2

The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.
=end comment

my @Test =
    [0,]    => [1,],
    [0,1]   => [2,],
    [1,2]   => [0,],
    [0,2]   => [1,],
    [-1,-2] => [0,1,2],
    [-1,3]  => [0,1,2],
    [3,4]   => [0,1,2],
;

sub missing-numbers( @a -->Array) {
    @ = [0..@a.elems].grep: * != (grep ( -1 < * ≤  @a.elems),@a).any;
}

plan +@Test;

for @Test -> (:key(@in), :value(@exp)) {
        is missing-numbers( @in), @exp, "@in[]";
}
done-testing;

my @array = pick 5, -3..8;
say @array.sort;
say "Input: \@array = @array[]\nOutput: ", missing-numbers( @array);

