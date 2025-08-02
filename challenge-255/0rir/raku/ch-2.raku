#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
255-2: Most Frequent Word       Submitted by: Mohammad Sajid Anwar
Given a paragraph $p and a banned word $w.

Write a script to return the most frequent word that is not banned.

Example 1
Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
       $w = "hit"
Output: "ball"

The banned word "hit" occurs 3 times.
The other word "ball" occurs 2 times.
Example 2
Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
       $w = "the"
Output: "Perl"

The banned word "the" occurs 3 times.
The other word "Perl" occurs 2 times.
=end comment

my @Test =
    "Joe hit a ball, the hit ball flew far after it was hit.",
        "hit",  "ball",
    "Perl and Raku belong to the same family. Perl is the most "
    ~ "popular language in the weekly challenge.",
        "the", "Perl",
     "Dogs like cats, cats like mice, mice like cheese.",
        'Dogs', 'like',
    "Pearl bought a pearl at a seafood shop.",          # NOTE: case issues
        'seafood', 'a',
    "Dogs like cats, cats like mice, mice like cheese.",
        'cheese', 'like',
    "a a a  b b c d e", 'e', 'a',
;

my @Die =
    "Dogs like cats, cats like mice, mice like cheese.",
        'like', 'cats',
;

plan (@Die + @Test) ÷ 3;

my regex word { <:L>+ };

sub func( $text, $ban-word ) {
    my Bag $word = Bag.new(
        $text.comb( / <word> /).grep( { ! / $ban-word/}));
    my $candidate = ($word.grep: *.value == $word.values.max )».key;
    die "Multiple candidates" if +@$candidate > 1;
    $candidate;              # if @candi -Naive use of array of size 1 as *[0]
}

for @Test -> $pp, $ban, $exp {
    is func($pp, $ban), $exp, "$exp <- $ban <-$pp";
}
for @Die -> $pp, $ban, $exp {
    dies-ok { func($pp, $ban) }, "DIES <- $ban <-$pp";
}

done-testing;
my $t = "Joe hit a ball, the hit ball flew far after it was hit.";
my $b = "hit";

say qq{\nInput: \$p = "$t"\n       \$w = "$b"\nOutput: "&func( $t,$b)"};

exit;

