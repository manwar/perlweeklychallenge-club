#!/usr/bin/env raku
use Test;

is zero-friend(4, 2, -1, 3, -2),     1;
is zero-friend(-5, 5, -3, 3, -1, 1), 1;
is zero-friend(7, -3, 0, 2, -8),     0;
is zero-friend(-2, -5, -1, -8),      1;
is zero-friend(-2, 2, -4, 4, -1, 1), 1;

sub zero-friend(+@nums)
{
    @nums.map(*.abs).min
}
