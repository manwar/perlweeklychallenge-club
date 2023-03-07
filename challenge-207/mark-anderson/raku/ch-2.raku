#!/usr/bin/env raku
use Test;

is h-index(10, 8, 5, 4, 3), 4;
is h-index(25, 8, 5, 3, 3), 3;
is h-index(25, 8, 3, 3, 3), 3;
is h-index(3),              1;
is h-index(3, 2),           2;
is h-index(0, 0, 0),        0;
is h-index(0, 0, 0, 1),     1;
is h-index(1, 1, 1, 1, 1),  1;
is h-index(9, 9, 9, 9, 9),  5;

sub h-index(*@a)
{
    @a.sort(-*).pairs.first({ .key < .value }, :end).key.succ // 0
}
