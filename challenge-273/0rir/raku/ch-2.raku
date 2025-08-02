#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
273-2: B After A            Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to return true if there is at least one b, and no a appears after the first b.

Example 1
Input: $str = "aabb"
Output: true
Example 2
Input: $str = "abab"
Output: false
Example 3
Input: $str = "aaa"
Output: false
Example 4
Input: $str = "bbb"
Output: true

=end comment

my @Test =
    "aabb",     True,
    "abab",     False,
    "aaa",      False,
    "bbb",      True,
    "ccc",      False,
    "cbc",      True,
    "cac",      False,
    "cab",      True,
;
plan @Test ÷ 2;

sub task( $word) {
    my @w = $word.comb;
    without my $b-k =              @w.first( 'b', :k) { return False }
    with
                      @w[++$b-k..^@w].first( 'a')     { return False  }
    True;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp\t<- $in";
}

done-testing;


