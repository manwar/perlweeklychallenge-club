#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
353-1: Max Words            Submitted by: Mohammad Sajid Anwar
You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single sentence.


Example 2
Input: @sentences = ("Single")
Output: 1

Example 3
Input: @sentences = ("Short", "This sentence has seven words in total", "A B C", "Just four words here")
Output: 7

Example 4
Input: @sentences = ("One", "Two parts", "Three part phrase", "")
Output: 3

Example 5
Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")
Output: 10

=end comment

my @Test =
    4,  ("Hello world", "This is a test", "Perl is great"),
    1,  ("Single",),
    7,  ("Short", "This sentence has seven words in total",
            "A B C", "Just four words here"),
    3,  ("One", "Two parts", "Three part phrase", ""),
    10, ("The quick brown fox jumps over the lazy dog", "A",
            "She sells seashells by the seashore",
            "To be or not to be that is the question"),
;
plan +@Test ÷ 2;

sub task( List:D $a -->Int) {
    max $a.map: + *.split( :skip-empty, /\s+/)
}

for @Test -> $exp, $in {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @sentence = "Hello world", "This is a test", "Perl is great";

say qq{\nInput: @sentence = ("} ~ @sentence.join('", ') ~ qq{")\n}
    ~ "Output: ", task @sentence;
