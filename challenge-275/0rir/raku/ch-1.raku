#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Broken Keys
Submitted by: Mohammad Sajid Anwar
You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

Example 1
Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0
Example 2
Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.
Example 3
Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2
Example 4
Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2
=end comment

my @Test =
    #   words                   disease         healthy count
    "Perl and Raku",            ('a',),         1,
    "Perl Weekly Challenge",    ('l', 'a'),     0,
    "Well done Team PWC",       ('l', 'o'),     2,
    "The joys of polyglottism", ('T',),         2,
    "The horrors of babel",     (),             4,

;
plan @Test ÷ 3;

only task( $sentence is copy, @poison --> Int) {
    + $sentence.words».contains( /:ignorecase @poison /).grep( !*);
}

for @Test -> $in, @poison, $exp {
    is task($in, @poison), $exp, "$exp <- $in [ @poison[]]";
}

done-testing;

my $sentence = "Perl and Raku";
my @key = ('p',);

say qq{\nInput: \$sentence = "Perl and Raku", @keys = @key[]\n}
    ~ "Output: ", task $sentence, @key;
