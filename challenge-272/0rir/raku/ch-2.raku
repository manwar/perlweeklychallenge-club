#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 2: String Score
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to return the score of the given string.

The score of a string is defined as the sum of the absolute difference between the ASCII values of adjacent characters.

Example 1
Input: $str = "hello"
Output: 13

ASCII values of characters:
h = 104
e = 101
l = 108
l = 108
o = 111

Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
      => 3 + 7 + 0 + 3
      => 13
Example 2
Input: "perl"
Output: 30

ASCII values of characters:
p = 112
e = 101
r = 114
l = 108

Score => |112 - 101| + |101 - 114| + |114 - 108|
      => 11 + 13 + 6
      => 30
Example 3
Input: "raku"
Output: 37

ASCII values of characters:
r = 114
a = 97
k = 107
u = 117

Score => |114 - 97| + |97 - 107| + |107 - 117|
      => 17 + 10 + 10
      => 37
=end comment

my @Test =
     "perl",        30,
     "hello",       13,
     "raku",        37,
;
plan @Test ÷ 2;


sub task( $a) {
    $a.comb».ord.rotor(2 => -1).map( { abs( .[0] - .[1])}).sum;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}
done-testing;
