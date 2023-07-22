#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment

226-2: Zero Array           Submitted by: Mohammad S Anwar
Given an array of non-negative integers, @ints, return the minimum number of
operations to make every element equal zero.  
In each operation, you are required to pick a positive number less than or
equal to the smallest element in the array, then subtract that from each positive element in the array.

Example 1:
Input: @ints = (1, 5, 0, 3, 5)
Output: 3

operation 1: pick 1 => (0, 4, 0, 2, 4)
operation 2: pick 2 => (0, 2, 0, 0, 2)
operation 3: pick 2 => (0, 0, 0, 0, 0)
=end comment

# NOTE: Per the instructions.  No solution unless all values are same.

my @Test =
    Int, [,],
    0,   [0,0],
    Int, [1,2],
    1,   [1,1],
    Int, [1,5,0,3,5],
    Int, [10, 8, 20],
;

plan @Test ÷ 2;

sub func( @a is copy -->Int) {
    return Int if @a ~~ [];
    return  0  if @a.all == 0;
    return  1  if @a.all == @a[0];
    return Int;
}

for @Test -> $exp, @in {
    is func(@in), $exp, "$exp.raku() <-- @in.raku()"; 
}
done-testing;
exit;

