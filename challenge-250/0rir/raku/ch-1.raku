#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
Task 1: Smallest Index
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints.

Write a script to find the smallest index i such that i mod 10 == $ints[i] otherwise return -1.

Example 1
Input: @ints = (0, 1, 2)
Output: 0

i=0: 0 mod 10 = 0 == $ints[0].
i=1: 1 mod 10 = 1 == $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
All indices have i mod 10 == $ints[i], so we return the smallest index 0.
Example 2
Input: @ints = (4, 3, 2, 1)
Output: 2

i=0: 0 mod 10 = 0 != $ints[0].
i=1: 1 mod 10 = 1 != $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
i=3: 3 mod 10 = 3 != $ints[3].
2 is the only index which has i mod 10 == $ints[i].
Example 3
Input: @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)
Output: -1
Explanation: No index satisfies i mod 10 == $ints[i].
=end comment

my @Test =
    10, (0, 1, 2), 0,
    10, (4, 3, 2, 1), 2,
    10, (1, 2, 3, 4, 5, 6, 7, 8, 9, 0), -1,
    2,  ( 5, 1, 3), 1,
    7,  ( 0, 7, 7, 7), 0,
    7,  ( 7, 7, 7, 7, 7, 5), 5,
    100, ( 4, 4, 4, 4, 4, 4), 4,
    -1, ( -1,-1,-1,), -1,
    -10,(), -1,
;
plan @Test ÷ 3;

multi func( Int $int where $int < 0, $list ) { -1 }; 
multi func( Int $int, $list -->Int:D) {
    my $min = $list.pairs.grep( { .key % $int == .value}).min;
    $min ~~ Pair    ?? $min.value   !! -1;
}

for @Test -> $int, $list, $exp {
    is func($int, $list), $exp,
            sprintf "%3i <- %3i R%% %s", $exp, $int, $list.raku;
}

done-testing;
my @int = 4,3,2,1;

say "\nInput: @int = (@int[])\nOutput: &func(10,@int)";
exit;

