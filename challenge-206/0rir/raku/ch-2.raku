#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use Test;

=begin comment

206-2: Array Pairings       Submitted by: Mohammad S Anwar

Given an array of integers having even number of elements, find the
maximum sum of the minimum of each pairs.

Example 1
Input: @array = (1,2,3,4)
Output: 4

Possible Pairings are as below:
a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3

So the maximum sum is 4.
Example 2
Input: @array = (0,2,1,3)
Output: 2

Possible Pairings are as below:
a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1

So the maximum sum is 2.
=end comment

my @Test =
    ( [,].Array,            0),
    ( Empty.Array,          0),
    ( Array,                0),
    ([1,2],                 1),
    ([0,1,3,2],             2),
    ([2,3,4,1],             4),
    ([1,4,1,4],             5),
    ([4,1,4,4],             5),
    ([4,4,4,4],             8),
    ([1,2,3,4,5,6],         9),
    ([3,4,5,6,9,10],       17),
    ([1,4,5,6,9,10],       15),
    ([1,4,6,10,10,10],     17),

    ([1,2,3,4,5,6,7,8],            16),
    ([1,8,9,10,11,12,33,14,15,16], 51), 
;

multi sub max-sum-of-mins-for-dyads( @a where @a.elems %% 2 --> Int) {
        # sort and take very other one
    sum @a.sort( { $^a <=> $^b })[ (0..@a.end).grep(* %% 2)];
}
multi sub max-sum-of-mins-for-dyads( @a where not *.defined --> Int) { 0 }
multi sub max-sum-of-mins-for-dyads( @a where *.elems == 0  --> Int) { 0 }

plan +@Test;

for @Test -> ( @in, $exp) {
    is max-sum-of-mins-for-dyads( @in), $exp, "@in.raku() => $exp";
}

done-testing;

my @ary = 1,8,9,10,11,12,33,14,15,16;
say "\nInput: @array = @ary.raku()\nOutput: &max-sum-of-mins-for-dyads( @ary)";

