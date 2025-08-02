#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∋∩∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
319-2: Minimum Common       Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays. If none found return -1.

Example 1
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3

The common integer in both arrays: 3, 4
The minimum is 3.

Example 2
Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2

Example 3
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1
=end comment

my @Test =
    # in1           in2             exp
    (1, 2, 3, 4),   (3, 4, 5, 6),      3,
    (1, 2, 3),      (2, 4),            2,
    (1, 2, 3, 4),   (5, 6, 7, 8),    Int,
    (-10,1,2,34),   (1,2, 70000),      1,
    (-10,1,2,34),   (-10,2,70000),   -10,
    (-1,),          (-1,10),          -1,
    ( 5,10,20,),    ( 100,20),         20,
    ( 5,10,100,),   ( 100,20),        100,
;
plan @Test ÷ 3;

sub task( List $a, List $b -->Int) {
    my $ret = ( $a.Set ∩ $b.Set).keys.min;
    $ret == ∞ ?? Int !! $ret;
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "{$exp//$exp.^name()} <- $a.raku() ∘∘ $b.raku()";
}
done-testing;

my @a = (10, -1, 20,);
my @b = (-1, 20, 10,);

say qq{\nInput: @array_1 = (@a.join(', '));}
  ~ qq{\n       @array_2 = (@b.join(', '));}
  ~   "\nOutput: {task @a, @b}";

