#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;
use experimental :cached;

=begin comment
291-2: Poker Hand Rankings      Submitted by: Robbie Hatley
A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers,
no wild cards. An ace can rank either high or low.

Write a script to determine the following three things:

1. How many different 5-card hands can be dealt?
2. How many different hands of each of the 10 ranks can be dealt?
   See here for descriptions of the 10 ranks of Poker hands:
   https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
3. Check the ten numbers you get in step 2 by adding them together
   and showing that they're equal to the number you get in step 1.
=end comment


my constant @factorial is export = 1, * × ++$ … ∞;

sub bang( Int $n) { @factorial[$n] }

sub nCr ( UInt $n, UInt $k where * ≤ $n -->Int) is cached {
    bang( $n) div ( bang( $k) × bang( $n - $k) )
}

my Int $Royal     =  nCr(4,1);
my Int $Str-Flush =  nCr(10,1) * nCr(4,1)   -  $Royal;
my Int $Four      =  nCr(13,1) * nCr(4,4)   *  nCr(12,1) * nCr(4,1);
my Int $Full      =  nCr(13,1) * nCr(4,3)   *  nCr(12,1) * nCr(4,2);
my Int $Flush     =  nCr(13,5) * nCr(4,1)   -  $Royal     - $Str-Flush;
my Int $Straight  =  nCr(10,1) * nCr(4,1)⁵  -  $Royal     - $Str-Flush;
my Int $Threesome =  nCr(13,1) * nCr(4,3)   *  nCr(12,2) * nCr(4,1)²;
my Int $Two-Pair  =  nCr(13,2) * nCr(4,2)²  *  nCr(11,1) * nCr(4,1);
my Int $Twosome   =  nCr(13,1) * nCr(4,2)   *  nCr(12,3) * nCr(4,1)³;
my Int $High      = (nCr(13,5) - nCr(10,1)) * (nCr(4,1)⁵ - nCr(4,1));
my Int $All       =  nCr(52,5);

my @Test =
    $Royal,           4,
    $Str-Flush,      36,
    $Four,          624,
    $Full,        3_744,
    $Flush,       5_108,
    $Straight,   10_200,
    $Threesome,  54_912,
    $Two-Pair,  123_552,
    $Twosome, 1_098_240,
    $High,    1_302_540,
    $All,     2_598_960,
;
plan @Test ÷ 2;

for @Test -> $in, $exp {
    is $in, $exp, "$exp <- $in Against known.";
}
done-testing;

sub commafy( Int $v -->Str) {
    $v.flip.comb(3).join(',').flip;
}


my @name = "Royal Flush", 'Straight Flush', 'Four of a Kind', 'Full House',
            'Flush', 'Straight', 'Three of a Kind', 'Two Pair', 'High Card';
my @count = $Royal, $Str-Flush, $Four, $Full, $Flush,
           $Straight, $Threesome, $Two-Pair, $High;
say "\nCount of all hands:   ", $All.&commafy;

say "\nCount of hand ranks:";
for @name Z @count -> ($n, $c) {
    printf "%21s%-15s%12s\n", ' ',      $n,   $c.&commafy;
}
    printf "%21s%-15s%12s\n", ' ',     ' ',  "_" x 12;
    printf "%21s%-15s%12s\n", ' ', 'Total', $All.&commafy;



