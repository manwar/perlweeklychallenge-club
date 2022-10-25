#!/usr/bin/env raku
use Test;

is divisible-pairs((4, 5, 1, 6), 2), 2;
is divisible-pairs((1, 2, 3, 4), 2), 2;
is divisible-pairs((1, 3, 4, 5), 3), 2;
is divisible-pairs((5, 1, 2, 3), 4), 2;
is divisible-pairs((7, 2, 4, 5), 4), 1;
is divisible-pairs((2, 2, 2, 2), 2), 6;

sub divisible-pairs($list, $k)
{
    +$list.combinations(2).grep({ .sum %% $k })
}
