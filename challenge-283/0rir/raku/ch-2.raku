#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
283-2: Digit Count Value            Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range
0 <= i < size of array, the digit i occurs exactly the $ints[$i] times
in the given array otherwise return false.

Example 1
Input: @ints = (1, 2, 1, 0)
Ouput: true

$ints[0] = 1, the digit 0 occurs exactly 1 time.
$ints[1] = 2, the digit 1 occurs exactly 2 times.
$ints[2] = 1, the digit 2 occurs exactly 1 time.
$ints[3] = 0, the digit 3 occurs 0 time.
Example 2
Input: @ints = (0, 3, 0)
Ouput: false

=end comment

my @Test =
    (1).comb.List,                  False,
    (0).comb.List,                  False,
    (10).comb.List,                 False,
    (212).comb.List,                False,
    (030).comb.List,                False,
    (3000).comb.List,               False,
    (40000).comb.List,              False,
    (31000).comb.List,              False,
    (3312000).comb.List,            False,
    (4301000).comb.List,            False,
    (9122000001).comb.List,         False,
    (1210.comb.List),               True,
    (2020.comb.List),               True,
    (21200.comb.List),              True,
    (3211000.comb.List),            True,
    (521001000.comb.List),          True,
    (6210001000.comb.List),         True,
    (72100001000.comb.List),        True,
    (821000001000.comb.List),       True,
    (9210000001000.comb.List),      True,
;
plan @Test ÷ 2;

sub task( $a) {
    for ^$a -> \i {
        return False unless  $a.grep( i ) == $a[ i];
    }
    True;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}
done-testing;

my @int = (4, 1, 0, 0, 0, 0);
say "\nInput: @ints = @int.raku()\nOuput: { task @int }";
