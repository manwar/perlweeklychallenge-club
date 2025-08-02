#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Counter Integers    Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters and digits.

Write a script to replace every non-digit character with a space and then return all the distinct integers left.

Example 1
Input: $str = "the1weekly2challenge2"
Output: 1, 2

2 is appeared twice, so we count it one only.

Example 2
Input: $str = "go21od1lu5c7k"
Output: 21, 1, 5, 7

Example 3
Input: $str = "4p3e2r1l"
Output: 4, 3, 2, 1
=end comment

my @Test =
    # in                        exp
    "the1weekly2challenge2",    (1, 2,),
    "go21od1lu5c7k",            (21, 1, 5, 7,),
    "4p3e2r1l",                 (4, 3, 2, 1,),
    "raku",                     (),
;
plan +@Test ÷ 2;

sub task( $a --> Array) {
    ( ($a ~~ m:g/\d+/ )».Str).unique.Array
}

for @Test -> $in, @exp {
    is task( $in), @exp, "{@exp // @exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "pqwo48957u10qt7430qr10uo105973hjf5973hj";

say qq/\nInput: \$str = "$str"\nOutput: "&task($str).join(', ')"\n/;
