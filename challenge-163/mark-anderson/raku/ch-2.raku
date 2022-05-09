#!/usr/bin/env raku

use Test;

is summations(1, 2, 3, 4, 5), 42;
is summations(1, 3, 5, 7, 9), 70;
is summations(1 .. 20)      , 6564120420;

sub summations(+@n)
{
    @n = [\+] @n.skip while @n > 1;
    @n
}
