#!/usr/bin/env raku
use Test;

is range-sum(<-2 0 3 -5 2 -1>, 0, 2),  1;
is range-sum(<1 -2 3 -4 5>,    1, 3), -3;
is range-sum(<1 0 2 -1 3>,     3, 4),  2;
is range-sum(<-5 4 -3 2 -1 0>, 0, 3), -2;
is range-sum(<-1 0 2 -3 -2 1>, 0, 2),  1;

sub range-sum(@ints, $x, $y)
{
    sum @ints[$x..$y]
}
