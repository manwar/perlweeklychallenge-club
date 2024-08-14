#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
282-1: Good Integer         Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int, having 3 or more digits.
Write a script to return the Good Integer in the given integer or -1 if
none found.

A good integer is exactly three consecutive matching digits.

Example 1
Input: $int = 12344456
Output: "444"
Example 2
Input: $int = 1233334
Output: -1
Example 3
Input: $int = 10020003
Output: "000"
=end comment

no worries;
 my @Test =
    000,        -1,
    100,        -1,
    123,        -1,
    111,        "111",
    1111,       -1,
    1121,       -1,
    1112,       "111",
    00011,      -1,
    21112,      "111",
    211112,     -1,
    000111,     "111",
    111000,     "111",
    111222,     "111",
    1111000,    "000",
    1110000,    "111",
    1111222,    "222",
    1234111,    "111",
    1233334,    -1,
    1234445,    "444",
    10020003,   "000",
    12344456,   "444",
    ('1234567890' x 100).Int, -1,
    ('11' ~ ('1234567890' x 100)).Int, '111',
    (('1234567890' x 100) ~ '00').Int, '000',
;

use worries;
plan @Test ÷ 2;

sub task( UInt $a -->Any) {

    if $a ~~  m:g/ ([$<w> = \d] $<w>**2..* )  / {
        return $/.list.first( *.chars == 3) // -1;
    }
    -1;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}

done-testing;
my $int = 999999999888888887777777666666555554444333221000;
say "\nInput: \$int = $int\nOutput: { task $int }\n";

