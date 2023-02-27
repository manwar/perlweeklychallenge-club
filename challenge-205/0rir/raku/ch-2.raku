#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
205-2: Maximum XOR          Submitted by: Mohammad S Anwar
Given an array of integers, find the highest value obtained by XORing any two distinct members of the array.

Example 1
Input: @array = (1,2,3,4,5,6,7)
Output: 7

The maximum result of 1 xor 6 = 7.
Example 2
Input: @array = (2,4,1,3)
Output: 7

The maximum result of 4 xor 3 = 7.
Example 3
Input: @array = (10,5,7,12,8)
Output: 7

The maximum result of 10 xor 5 = 15.
=end comment

my @Test =
    [( 1,),                  Int, ],
    [( 1,1,),                Int, ],
    [( 1,2,3,4,5,6,7),         7, ],
    [( 2,4,1,3),               7, ],
    [( 10,5,7,12,8),          15, ],
    [( -11,800),            -811, ],
    [( 1,11,111,1111,800),  1911, ],
    [( 13,13,9,1),            12, ],
    [( -100,1),              -99, ],
    [( -100,1,1),            -99, ],
;
plan +@Test;

multi highest-bitwise-xor-duo( @a where *.elems < 2 ) { Int }
multi highest-bitwise-xor-duo( @a --> Int) {
    return Int if @a.unique.elems < 2 ;
    max do ( $_[0] +^ $_[1]) for  @a.unique.combinations(2)
}
for @Test -> (@in, $exp) {
    is highest-bitwise-xor-duo( @in), $exp, "$exp.raku()\t<-- @in[]";
}
done-testing;

my @a = -100,1,1;
say "\nInput: @array = @a[]\n",
    "Output: &highest-bitwise-xor-duo( @a)";


