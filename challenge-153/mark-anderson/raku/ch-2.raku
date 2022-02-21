#!/usr/bin/env raku

say factorian(145);
say factorian(125);

sub factorian($n)
{
    + ($n == [+] $n.comb.map: {[*] 1..$_})
}
