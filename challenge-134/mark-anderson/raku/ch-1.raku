#!/usr/bin/env raku

say pandigital(100);
say pandigital(999);
say pandigital(^5);
say pandigital(400, 300, 200, 100, 0);

sub pandigital(+$arr where .all ~~ UInt)
{
    (1023456789.comb.permutations)[|$arr]>>.join.join(', ');
}
