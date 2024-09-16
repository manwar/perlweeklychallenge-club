#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
284-1 Lucky Integer         Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, find the lucky integer if found
otherwise return -1. If there are more than one then return the largest.
A lucky integer is an integer that has a frequency in the array equal
to its value.

Example 1
Input: @ints = (2, 2, 3, 4)
Output: 2
Example 2
Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3
Example 3
Input: @ints = (1, 1, 1, 3)
Output: -1

=end comment

my @Test =
    (),                     Int,
    (1),                    1,
    (3,3,3),                3,
    (2, 2, 3, 4),           2,
    (1, 2, 2, 3, 3, 3),     3,
    (1, 1, 1, 3),           Int,
    (-1,-2,-2),             Int,
    ( 1, ∞, 2, ∞ ),         1,
;
plan @Test ÷ 2;

sub task( $list -->Int) {
    my %h = $list.BagHash;
    quietly %h.values.grep( {%h{$_} == $_}).sort.reverse[0] // Int;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp.raku() <- $in";
}

done-testing;

my @int = (-1,2,2,2,2,1,3,3,2,3,);
say "\nInput: @int = @int[]\nOutput: { task( @int) // 1}";

