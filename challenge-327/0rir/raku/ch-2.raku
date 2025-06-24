#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
327-2: MAD          Submitted by: Mohammad Sajid Anwar
You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference (MAD) of any two elements.

Example 1
Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

The minimum absolute difference is 1.
Pairs with MAD: [1,2], [2,3], [3,4]

Example 2
Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]

Example 3
Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]
=end comment

my @Test =
    (4, 1, 2, 3),       [[1,2], [2,3], [3,4]],
    (1, 3, 7, 11, 15),  [[1,3],],
    (1, 5, 3, 8),       [[1,3], [3,5]],
;
plan +@Test ÷ 2;

multi task( @a is copy where *.elems > 1 ) {
    @a = @a.sort.rotor( 2=> -1)».Array;
    @a =  @a[ (@a.map( { $_[1] - $_[0] }) ).min( :k)];
    
}

for @Test -> @in, @exp {
    is task( @in).raku, @exp.raku, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

my @int = 1, 5, 3, 8, 15, 19, 21, 23, -48, -70, -50, -46, 25, 13;

say qq{\nInput: @int = @int.raku()\nOutput: }, task @int;
