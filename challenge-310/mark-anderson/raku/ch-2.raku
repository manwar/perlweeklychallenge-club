#!/usr/bin/env raku
use Test;

is-deeply sort-odd-even(4,1,2,3),   (2,3,4,1);
is-deeply sort-odd-even(3,1),       (3,1);
is-deeply sort-odd-even(5,3,2,1,4), (2,3,4,1,5);

sub sort-odd-even(+@ints)
{
    flat roundrobin @ints[0,2...*].sort, @ints[1,3...*].sort(-*)
}
