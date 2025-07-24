#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
331-1: Last Word
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to find the length of last word in the given string.

Example 1
Input: $str = "The Weekly Challenge"
Output: 9

Example 2
Input: $str = "   Hello   World    "
Output: 5

Example 3
Input: $str = "Let's begin the fun"
Output: 3
=end comment

my @Test =
    # in                            exp
    "The Weekly Challenge",         9,
    "   Hello   World    ",         5,
    "Let's begin the fun",          3,
    "Let's begin the fun...",       3,
    qq{ ' " ... " - + @ .},         0,
    qq{ Let's " ... " - + @ .},     1,
    qq{ Let's " ... " - + @ .so},   2,
    "",                             0,
    "   . ",                        0,
    "'",                            0,
;
plan +@Test ÷ 2;

my \non-word = regex { [\W | _ ]+ };   # some definition of non-word characters

sub task( Str:D $a -->Int) {
    my @a = $a.split( non-word, :skip-empty);
    return 0 unless @a;
    @a.tail.chars;
}

for @Test -> $in, $exp, {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in";
}
done-testing;

my $str = "Let's begin the fun now...";
say qq{\nInput: \$str = "$str"\nOutput: }, task $str;

