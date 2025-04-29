#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
318-1: Group Position       Submitted by: Mohammad Sajid Anwar
You are given a string of lowercase letters.

Write a script to find the position of all groups in the given string. Three or more consecutive letters form a group. Return "” if none found.

Example 1
Input: $str = "abccccd"
Output: "cccc"

Example 2
Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"

Example 3
Input: $str = "abcdd"
Output: ""
=end comment

my @Test =
    # in                   exp                    pretty
    "abccccd",          ["cccc",],               q{"cccc"},
    "aaabcddddeefff",   ["aaa", "dddd", "fff",], q{"aaa", "dddd", "fff"},
    "abcdd",            ["",],                   q{""},
;
plan @Test × 2 ÷ 3;

sub task( $s -->List) {
    my regex trip-up { (<:alpha>) $0 ** 2..* }
    my $m = ($s ~~ m:g/ <trip-up> /)».Str;
}
sub pretty( List $l --> Str) { '"' ~ $l.join( '", "') ~ '"'; }

for @Test -> $in, @exp, $pretty {
    is task( $in), @exp, "@exp.raku() <- $in.raku()";
    is pretty(task($in)), $pretty; 
}
done-testing;

my  $str = "aaabcddddeefff";

say qq{\nInput: \$str = "$str"\nOutput: { pretty task $str}};

