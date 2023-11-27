#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;


=begin comment
244-1: Count Smaller        Submitted by: Mohammad S Anwar
Given an array of integers, write a script to calculate the number of
integers smaller than the integer at each index.

Example 1
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
Example 2
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
Example 3
Input: @int = (2, 2, 2)
Output: (0, 0, 0)
Task 1: Count Smaller
Submitted by: Mohammad S Anwar
You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

Example 1
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
Example 2
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
Example 3
Input: @int = (2, 2, 2)
Output: (0, 0, 0)

=end comment

my @Test =
    # in                exp
    (8, 1, 2, 2, 3),    (4, 0, 1, 1, 3),
    (6, 5, 4, 8),       (2, 1, 0, 3),
    (2, 2, 2),          (0, 0, 0),
;
plan @Test ÷ 2;

sub func( @a --> Array) {
   @a.map( { @a.grep( * < $_).Int}).Array;
}

for @Test -> @in, @exp {
    is func(@in), @exp, "@in.raku() -> @@exp.raku()";
}
done-testing;

my @int = 1,2,7,9,4,0,-1;

say "\nInput: @int = @int[]\nOutput: ", func @int;

exit;

