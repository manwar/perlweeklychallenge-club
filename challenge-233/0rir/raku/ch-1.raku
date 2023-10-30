#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
233-1: Similar Words            Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabets only.

Write a script to find the number of pairs of similar words. Two words are similar if they consist of the same characters.

Example 1
Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2

Pair 1: similar words ("aba", "aabb")
Pair 2: similar words ("bac", "aabc")
Example 2
Input: @words = ("aabb", "ab", "ba")
Output: 3

Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")
Example 3
Input: @words = ("nba", "cba", "dba")
Output: 0

=end comment

my @Test =
    0, ( "a",),
    1, ( "a", "a"),
    0, ("nba", "cba", "dba"),
    2, ("aba", "aabb", "abcd", "bac", "aabc"),
    3, ("aabb", "ab", "ba"),
    4, ("aba", "aabb", "abc", "bac", "aabc"),
    11, ("ab", "ba", "ac", "ca", "aac", "aacc", "aaac"),

;
plan @Test ÷ 2;

my $i = 3;
my @p = 0,0,1,3, -> $a { $a+$i++} … ∞;

sub similar( @a --> Int) {
    my @c = @a.map( *.split('', :skip-empty).unique.sort);
    my %h;
    for @c { quietly %h{$_}++  }
    sum @p[%h.values];
}

for @Test -> $exp, @in {
    is similar(@in), $exp, "$exp <- @in.raku()";
}
done-testing;

my @word = "ab", "ba", "abb", "bab", "ac", "ca", "aac", "aacc", "aaac", "accc";


say "\n\nInput: @word = @word[]\nOutput: ", similar( @word);
