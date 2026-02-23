#!/usr/bin/env raku
use Lingua::EN::Numbers;
use Test;

is-deeply spellbound-sort(6,7,8,9,10),    (8,9,7,6,10);
is-deeply spellbound-sort(-3,0,1000,99),  (-3,99,1000,0);
is-deeply spellbound-sort(1,2,3,4,5),     (5,4,1,3,2);
is-deeply spellbound-sort(0,-1,-2,-3,-4), (-4,-1,-3,-2,0);
is-deeply spellbound-sort(100,101,102),   (100,101,102);

sub spellbound-sort(+@a)
{
    @a.sort: { cardinal($_) }
}
