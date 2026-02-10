#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
360-Task 2: Word Sorter         Submitted by: Mohammad Sajid Anwar

You are give a sentence.
Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged.

Example 1
Input: $str = "The quick brown fox"
Output: "brown fox quick The"
=end comment

my @Test =
    "The quick brown fox",                  "brown fox quick The",
    "Hello    World!   How   are you?",     "are Hello How World! you?",
    "Hello",                                "Hello",
    "Hello, World! How are you?",           "are Hello, How World! you?",
    "I have 2 apples and 3 bananas!",       "2 3 and apples bananas! have I",
;
plan +@Test ÷ 2;

sub task( Any:D(Str) $a -->Str) {
    $a.words.sort( {$^a.fc cmp $^b.fc}).join(' ')
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str =    "Raku raku raku Raku, pick one";
say qq{\nInput: \$str = "$str"\nOutput: "&task($str)"};

