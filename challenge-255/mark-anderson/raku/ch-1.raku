#!/usr/bin/env raku
use Test;

is odd-character("Perl", "Preel"),     "e";
is odd-character("Weekly", "Weeakly"), "a";
is odd-character("Box", "Boxy"),       "y";

sub odd-character($s, $t)
{
    $t.comb.Bag (-) $s.comb.Bag
}
