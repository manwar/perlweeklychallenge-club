#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆≡≢«␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
370-1: Popular Word         Submitted by: Mohammad Sajid Anwar
You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It is guaranteed there is at least one word that is not banned and the answer is unique. The words in paragraph are case-insensitive and the answer should be in lowercase. The words can not contain punctuation symbols.
=end comment

my @Test =
    # in  banned  exp
    "Bob hit a ball, the hit BALL flew far after it was hit.",
        ("hit"),
            "ball",
    "Apple? apple! Apple, pear, orange, pear, apple, orange.",
        ("apple", "pear"),
            "orange",
    "A. a, a! A. B. b. b.",
        ("b"),
            "a",
    "Ball.ball,ball:apple!apple.banana",
        ("ball"),
            "apple",
    "The dog chased the cat, but the dog was faster than the cat.",
        ("the", "dog"),
            "cat",
;
plan +@Test ÷ 3;

multi task( Str:D() $in,          Str     $bad -->Str) { task $in, [$bad] }
multi task( Str:D() $in is copy,  Array() $bad -->Str) {
    ($in.trans: ('A'..'Z', /<:P>/) => ('a'..'z', ' '))
                    .words.Bag.grep(*.key !(elem) $bad).max(*.value).key;
}
for @Test -> $in, $bad, $exp {
    is task( $in, $bad), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.";
my @banned = "hit";

say qq{\nInput: \$paragraph = "$paragraph"\n},
    qq{       @banned = ("@banned.join(", ")")\n},
    qq{Output: "}, task( $paragraph, @banned), '"';

