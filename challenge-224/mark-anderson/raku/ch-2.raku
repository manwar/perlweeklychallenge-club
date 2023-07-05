#!/usr/bin/env raku
use Test;

ok  additive-number("112358"),              "1,2,2,3,5,8";
nok additive-number("12345"),               "No Solution";
ok  additive-number("199100199"),           "1,99,100,199";
ok  additive-number("4588321981458832199"), "458832198,1,458832199";
ok  additive-number("1321517324981130211"), "13,2,15,17,32,49,81,130,211";

sub additive-number($n)
{
    my $a = $n.substr(0, ($n.chars div 2).succ);
    my $b = $n.substr(($n.chars div 2).succ, *);

    for (1..$a.chars.succ).combinations(2) -> ($h, $t)
    {
        my $s := $n.substr(0, $h), $n.substr($h, $t-$h), { $^a + $^b } ... * >= $b;
        return True if $s.join.substr(0, $n.chars) eq $n;
    }

    return False
}
