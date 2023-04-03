#!/usr/bin/env raku
use Test;

ok  split-same-avg(1,2,3,4,5,6,7,8); # [1 8] [5 4 6 3 7 2]
nok split-same-avg(1,3);
ok  split-same-avg(3,3,5,5,5,2,2,1); # [3 3 5 2] [2 5 5 1]
nok split-same-avg(5,5,5,2,2,1); 

sub split-same-avg(*@nums)
{
    for (^@nums).combinations(1..(@nums.elems div 2)) -> @a is copy
    {
        my @b = ((^@nums) (-) @a).keys;

        @a = @nums[@a];
        @b = @nums[@b];

        return True if (@a.sum / @a.elems) == (@b.sum / @b.elems)
    }

    return False
}
