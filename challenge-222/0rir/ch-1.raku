#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
222-1: Matching Members         Submitted by: Mohammad S Anwar

Given a list of positive integers, @ints, find the total matching members
after sorting the list increasing order.

Example 1
Input: @ints = (1, 1, 4, 2, 1, 3)
Output: 3

Original list: (1, 1, 4, 2, 1, 2)
Sorted list  : (1, 1, 1, 2, 3, 4)
Compare the two lists, we found 3 matching members (1, 1, 2).

Example 2
Input: @ints = (5, 1, 2, 3, 4)
Output: 0

Example 3
Input: @ints = (1, 2, 3, 4, 5)
Output: 5
=end comment

my @Test =
    (1, 1, 4, 2, 1, 3), 3,
    (5, 1, 2, 3, 4),    0,
    (1, 2, 3, 4, 5),    5,
    (1,2,3,4,5,5,4,),   5,
    (),                 0,
;

plan @Test ÷ 2;

for @Test -> @in, $exp {
    is ([Z==] @in, @in.sort).grep( *.Bool ).elems
       , $exp
       , 'count matches';
}

done-testing;
my @int = (1,2,3,4,5,5,4,);
say "\n\nInput: @ints = @int.raku()\nOutput: ",
    ([Z==] @int, @int.sort).grep( *.Bool ).elems;

