#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Percentage of Character
Submitted by: Mohammad Sajid Anwar
You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given character in the given string.

Example 1
Input: $str = "perl", $char = "e"
Output: 25
Example 2
Input: $str = "java", $char = "a"
Output: 50
Example 3
Input: $str = "python", $char = "m"
Output: 0
Example 4
Input: $str = "ada", $char = "a"
Output: 67
Example 5
Input: $str = "ballerina", $char = "l"
Output: 22
Example 6
Input: $str = "analitik", $char = "k"
Output: 13
=end comment

my @Test =
   "perl",          "e",  25,
   "java",          "a",  50,
   "python",        "m",   0,
   "ada",           "a",  67,
   "ballerina",     "l",  22,
   "analitik",      "k",  13,
   'a',             "a", 100,
   'a' x 100 ~ 'b', 'a',  99,
   'a' x 100 ~ 'b', 'b',   1,
   'a' x 200 ~ 'b', 'a', 100,
   'a' x 200 ~ 'b', 'b',   0,
   'a' x 199 ~ 'b', 'a', 100,
   'a' x 199 ~ 'b', 'b',   1,
;
plan @Test ÷ 3;

sub task( $word, $letter) {
   my @w = $word.comb;
   (100 × @w.grep( $letter) ÷ @w).round;
}

for @Test -> $in, $letter, $exp {
    is task($in, $letter), $exp, "$exp <- ($letter) $in";
}

done-testing;
