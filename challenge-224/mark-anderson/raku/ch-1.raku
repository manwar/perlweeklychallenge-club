#!/usr/bin/env raku

say special-notes('abc', 'xyz');
say special-notes('scriptinglanguage', 'perl');
say special-notes('aabbcc', 'abc');

sub special-notes($s, $t)
{
    $t.comb.Bag (<=) $s.comb.Bag
}
