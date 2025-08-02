#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
263-1: Target Index         Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and a target element $k.

Write a script to return the list of indices in the sorted array where the element is same as the given target element.

Example 1
Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
Output: (1, 2)

Sorted array: (1, 2, 2, 3, 4, 5)
Target indices: (1, 2) as $ints[1] = 2 and $ints[2] = 2
Example 2
Input: @ints = (1, 2, 4, 3, 5), $k = 6
Output: ()

No element in the given array matching the given target.
Example 3
Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
Output: (4)

Sorted array: (1, 2, 2, 3, 4, 5)
Target index: (4) as $ints[4] = 4
=end comment

my @Test =
    #   in                  k   result
    (1, 5, 3, 2, 4, 2),     2, (1, 2),
    (1, 2, 4, 3, 5),        6, (),
    (5, 3, 2, 4, 2, 1),     4, (4),
;
plan @Test ÷ 3;

sub loca-of-value($a, $k) {
    $a.sort.grep( $k, :k).List;
}

for @Test -> $in, $k, $exp {
    is loca-of-value($in, $k), $exp, "$exp <- $k «- $in";
}

done-testing;

my @int = (5, 3, 2, 4, 2, 1);
constant \K = 4;
say "\nInput: @int = @int.raku(), K = $(K)\nOutput: ", loca-of-value( @int, K);
