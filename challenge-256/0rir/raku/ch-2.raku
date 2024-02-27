#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
256-2: Merge Strings            Submitted by: Mohammad Sajid Anwar
Given two strings, $str1 and $str2.

Write a script to merge the given strings by adding in alternative order starting with the first string. If a string is longer than the other then append the remaining at the end.

Example 1
Input: $str1 = "abcd", $str2 = "1234"
Output: "a1b2c3d4"
Example 2
Input: $str1 = "abc", $str2 = "12345"
Output: "a1b2c345"
Example 3
Input: $str1 = "abcde", $str2 = "123"
Output: "a1b2c3de"
=end comment

my @Test =
    # first  second     ab-result   ba-result
    "a",     "b",      "ab",      "ba",
    "abcd",  "1234",    "a1b2c3d4", "1a2b3c4d",
    "abc",   "12345",   "a1b2c345", "1a2b3c45",
    "abcde", "123",     "a1b2c3de", "1a2b3cde",
;
plan @Test ÷ 2;

sub interleave( Str $a where ?*.chars, Str $b where ?*.chars -->Str) {
    roundrobin($a.comb, $b.comb).flat.join;
}

for @Test -> $a, $b, $ab-exp, $ba-exp {
    is interleave($a, $b), $ab-exp, "$ab-exp <- $a interleave $b";
    is interleave($b, $a), $ba-exp, "$ba-exp <- $b interleave $a";
}

done-testing;
my $a = "123456789";
my $b = "abc";

say "\nInput: \$str1 = $a, \$str2 = $b\nOutput: &interleave($a,$b)";

exit;

