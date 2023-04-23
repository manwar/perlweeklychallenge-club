#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
213-1: Fun Sort             Submitted by: Mohammad S Anwar
Given a list of positive integers, sort the all even integers first then
all odds in ascending order.

Example 1
Input: @list = (1,2,3,4,5,6)
Output: (2,4,6,1,3,5)
Example 2
Input: @list = (1,2)
Output: (2,1)
Example 3
Input: @list = (1)
Output: (1)
=end comment

my @Test =
    # @in            @exp
    [],             [],
    [1,2,3,4,5,6],  [2,4,6,1,3,5],
    [1,2],          [2,1],
    [1],            [1],
    [100,100,99,9,10,2,3], [2,10,100,100,3,9,99],
    [1,2,3,-9,10],  [2,10,-9,1,3],
    [-100, 100, -99, -9 -10,2,3], [-100,2,100,-99,-19,3],
    [2,5,4,3,1,1,3,10,22,44,66,88,110,5,9,7],
    [2,4,10,22,44,66,88,110,1,1,3,3,5,5,7,9],
;
plan @Test ÷ 2;

for @Test -> @in, @exp {
    is @in.sort( { $_ % 2, $_}), @exp, "@in[] --> @exp[]";
}
my @list = 100,100,99,9,10,2,3;
say "\nInput: @list = (@list.join(','))
Output:  (@list.sort( { $_ % 2, $_}).join(','))";
exit;

