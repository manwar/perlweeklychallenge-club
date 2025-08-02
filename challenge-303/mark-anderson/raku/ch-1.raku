#!/usr/bin/env raku
use Test;

is-deeply three-evens(2,1,0,3),   (102,120,130,132,210,230,302,310,312,320);
is-deeply three-evens(2,2,8,8,2), (222,228,282,288,822,828,882);

sub three-evens(+@ints)
{
    my $bag = @ints>>.Str.Bag;
    (100,102...998).grep({ .comb.Bag (<=) $bag })
}
