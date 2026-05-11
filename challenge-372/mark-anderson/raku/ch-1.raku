#!/usr/bin/env raku
use Test;

is rearrange-spaces("  challenge  "),               "challenge    ";
is rearrange-spaces("coding  is  fun"),             "coding  is  fun";
is rearrange-spaces("a b c  d"),                    "a b c d ";
is rearrange-spaces("  team      pwc  "),           "team          pwc";
is rearrange-spaces("   the  weekly  challenge  "), "the    weekly    challenge ";

sub rearrange-spaces($str)
{
    my @words  = $str.words;
    my $spaces = ' ' x ($str.chars - @words.join.chars);
    my @spaces = $spaces.comb($spaces.chars div (@words.end or 1));
    (roundrobin @words, @spaces)>>.join.join
}
