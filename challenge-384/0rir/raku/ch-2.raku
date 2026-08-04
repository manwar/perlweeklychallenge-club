#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
384-2: Special Binary Substrings    Submitted by: Mohammad Sajid Anwar

You are given a binary string.
Write a script to return all non-empty substrings (distinct) that have the
same number of 0’s and 1’s, and all the 0’s and all the 1’s in these
substrings are grouped consecutively.
=end comment

my @Test =
    "0101",     ("01", "10"),                 # not <01 10 01>,
    "000111",   ("000111", "0011", "01"),
    "000011",   ("0011", "01"),
    "10011100", ("10", "0011", "01", "1100"),  # not <10 0011 01 1100, 10>,
    "00000",    (),
;
plan +@Test ÷ 2;

my regex zed_one { [ ( <[0]>+ )  ( <[1]>+ ) <?{ $0.chars == $1.chars}> ] }
my regex one_zed { [ ( <[1]>+ )  ( <[0]>+ ) <?{ $1.chars == $0.chars}> ] }

multi task( Mu:D(Str) $a where m/ ^ <[0…1]>+ $/ -->List)  {
    $a ~~ m:ov/ [ <&zed_one> | <&one_zed> ] /;

    if $/.defined {  ($/.».Str ).unique.List }
    else{            ();                     }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp.raku() <- $in";
}
done-testing;

my $binary = "000111";

say qq{\nInput: \$binary = "$binary"\nOutput: ("},
    task($binary).join('", "'),
    '")}';

