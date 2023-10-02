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

# NOTE: Per the example.  Every unique value greater than 0 adds 1 turn.

my @Test =
    Int,    [,],
    0,      [0,0],
    2,      [1,2],
    1,      [1,1],
    3,      [1,5,0,3,5],
    3,      [10, 8, 20],
    100,    (0..100),
    100,    (1..100),
    98,     (1^..^100),
    10_000, (0..10_000).pick(*),
;

plan @Test ÷ 2;

sub func( @a is copy -->Int) {
    return Int if @a ~~ [,];
    @a = @a.sort.squish;
    @a.shift if @a[0] == 0;
    return 0  if @a ~~ [,];
    return @a.elems;
}

for @Test -> $exp, @in {
    is func(@in), $exp, "$exp.raku() <-- @in.gist()"; 
}
done-testing;

my @int = (1, 5, 0, 3, 5);
say "\nInput: @ints = @int[]\n Output: ", func( @int);

