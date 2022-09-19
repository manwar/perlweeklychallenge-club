#!/usr/bin/env raku
use Test;

is first-max-index(5, 2, 9, 1, 7, 6),       2;
is first-max-index(4, 2, 3, 1, 5, 0),       4;
is first-max-index(4, 2, 3, 3, 5, 1, 5, 0), 4;

sub first-max-index(+$list)
{
    $list.maxpairs.head.key;
}
