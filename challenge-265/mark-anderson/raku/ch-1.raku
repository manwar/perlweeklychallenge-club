#!/usr/bin/env raku
use Test;

is thirty-three-appearance(1,2,3,3,3,3,4,2), 3;
is thirty-three-appearance(1,1),             1;
is thirty-three-appearance(1,2,3),           1;

sub thirty-three-appearance(*@ints)
{
    @ints.Bag.grep(*.value >= @ints / 3).min.key
}
