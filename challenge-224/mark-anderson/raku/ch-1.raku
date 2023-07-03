#!/usr/bin/env raku
use Test;

nok special-notes('abc', 'xyz');
ok  special-notes('scriptinglanguage', 'perl');
ok  special-notes('aabbcc', 'abc');

sub special-notes($s, $t)
{
    $t.comb.Bag (<=) $s.comb.Bag
}
