#!/usr/bin/env raku
use Test;

ok  double-exist(6,2,3,3);
nok double-exist(3,1,4,13);
ok  double-exist(2,1,4,2);

sub double-exist(+@ints)
{
    while @ints
    {
        return True if @ints.shift == 2 * any @ints
    }

    return False
}
