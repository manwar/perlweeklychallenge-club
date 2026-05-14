#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
372-1: Rearrange Spaces         Submitted by: Mohammad Sajid Anwar
You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of spaces between every pair of adjacent words and that number is maximised. If you can’t distribute, place the extra spaces at the end. Finally return the string.
=end comment

my @Test =
    "  challenge  ",                "challenge    ",
    "coding  is  fun",              "coding  is  fun",
    "a b c  d",                     "a b c d ",
    "  team      pwc  ",            "team          pwc",
    "   the  weekly  challenge  ",  "the    weekly    challenge ",
    "",                             "",
    "   ",                          "   ",
;
plan +@Test ÷ 2;

multi task( Str:D() $str -->Str:D) {
    my $a = $str;
    my $sp-ct = +$a.indices: ' ';
    my @w = $a.words;
    given +@w {
        when 0  { ' ' x $sp-ct; }
        when 1  { @w ~ ' ' x $sp-ct;   }
        default {
            @w.join( ' ' x $sp-ct div @w.end) ~ ' ' x $sp-ct % @w.end();
        }
    }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "'$exp'  <- '$in'";
}
done-testing;

my $str = "   the  weekly  challenge  ";
say qq{\nInput: \$str = "$str"\nOutput: "&task($str)"};
