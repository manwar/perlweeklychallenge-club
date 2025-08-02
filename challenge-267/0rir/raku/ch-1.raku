#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
267-1: Product Sign         Submitted by: Mohammad Sajid Anwar
You are given an array of @ints.

Write a script to find the sign of product of all integers in the given
array. The sign is 1 if the product is positive, -1 if the product is
negative and 0 if product is zero.

Example 1
Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
Output: 1

The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0
Example 2
Input: @ints = (1, 2, 0, -2, -1)
Output: 0

The product 1 x 2 x 0 x -2 x -1 => 0
Example 3
Input: @ints = (-1, -1, 1, -1, 2)
Output: -1

The product -1 x -1 x 1 x -1 x 2 => -2 < 0

=end comment

my @Test =
   Int, (),
   Int, ( 0,),
   Int, (-1,),
   Int, ( 1,),
    -1, ( 1, -1),
     1, ( 1,  1),
     0, ( 0,  0),
     0, ( 1,  0),
     0, (-1,  0),
     1, (-1, -2, -3, -4,  3,  2,  1),
     0, ( 1,  2,  0, -2, -1),
    -1, (-1, -1,  1, -1,  2),
     1, ( flat     -1 xx 10_000,    1 xx 9_999        ).List,
    -1, ( flat     -1 xx 9_999,     1 xx 9_999        ).List,
     0, ( flat 0,  -1 xx 100_000,   1 xx 99_999       ).List,
     0, ( flat     -1 xx 100_000,   1 xx 99_999,    0 ).List,
;

plan @Test ÷ 2;

sub mult-sign( List $a) {
    return Int if $a ~~ Empty or +@$a == 1;
    my ( $n, $z, $p) = hyper $a».sign.Bag{-1, 0, 1};      # Thanks Util
    return  0 if $z;
    return -1 unless $n %% 2;
    return  1;
}

for @Test -> $exp, $in {
    is mult-sign($in), $exp, "$exp.raku() <- $in.gist()";
}

done-testing;
my @int = flat -1 xx 11,1 xx 10;

say "\nInput: @int = @int[]\nOutput: &mult-sign(@int)";

exit;

