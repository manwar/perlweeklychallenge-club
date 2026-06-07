#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
376-1: Chessboard Squares
Submitted by: Mohammad Sajid Anwar
You are given two coordinates of a square on 8x8 chessboard.

Write a script to find the given two coordinates have the same colour.

8 W B W B W B W B
…
1 B W B W B W B W
  a b c d e f g h
￼
=end comment

my @Test =
#   sq1   sq2   exp
    "a7", "f4", True,
    "c1", "e8", False,
    "b5", "h2", False,
    "f3", "h1", True,
    "a1", "g8", False,
;
plan +@Test ÷ 3;

multi task($a, $b) {    die "Invalid in one of '$a' or '$b'" }

multi task(Cool $a is copy where m/ ^ <[a..h]> <[1..8]> $/,
           Cool $b is copy where m/ ^ <[a..h]> <[1..8]> $/ -->Bool:D) {
    for $a, $b <-> $_ {
        tr/a..h/1..8/;
        .=comb;
         $_ = .Array.sum %% 2;
    }
    $a == $b ;
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "$exp <- $a∘∘$b";
}
done-testing;

my $c1 = "e1";
my $c2 = "e8";

say qq{\nInput: \$c1 = "$c1", \$c2 = "$c2"\nOutput: }, task $c2, $c1;
