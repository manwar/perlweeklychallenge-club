#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
256-1: Maximum Pairs            Submitted by: Mohammad Sajid Anwar

Given an array of distinct words, @words, the maximum pairs in the given array. The words $words[i] and $words[j] can be a pair if one is reverse of the other.

Example 1
Input: @words = ("ab", "de", "ed", "bc")
Output: 1

Example 2
Input: @words = ("aa", "ba", "cd", "ed")
Output: 0
Example 3
Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")
Output: 2
=end comment

my @Test =
    0, (),
    0, ("ab",),
    0, ("ab","cd"),
    1, ("ab", "ba"),
    0, ("ab", "bc", "de", "ef"),
    1, ("ab", "de", "ed", "bc"),
    0, ("aa", "ba", "cd", "ed"),
    2, ("uv", "qp", "st", "vu", "mn", "pq"),
;

plan @Test ÷ 2 + 1;

sub reversed-wordpair-ct( @a -->Int) {
    die 'not distinct group' unless @a == @a.unique;
    (@a.map( *.flip) ∩ @a).elems div 2;
}

for @Test -> $exp, @in {
    is reversed-wordpair-ct(@in), $exp, "$exp <- @in[]";
}
dies-ok { reversed-wordpair-ct( <bad word list bad>) }, "bad word list dies";
done-testing;

my @word = "uv", "qp", "st", "vu", "mn", "pq";
say "\nInput: @words = @word.raku()\nOutput: &reversed-wordpair-ct( @word)";

exit;

