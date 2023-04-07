#!/usr/bin/env raku
use Test;

# This is a do-over after reading other's solutions.
# Jorg Sommrey and W. Luis Mochan explained that if one subset's average
# equals the average of the whole list then the other subset will have
# the same average. 

ok  split-same-avg(1,2,3,4,5,6,7,8); # [1 8] [2 3 4 5 6 7]
nok split-same-avg(1,3);
ok  split-same-avg(3,3,5,5,5,2,2,1); # [2 3 3 5] [1 2 5 5]
nok split-same-avg(5,5,5,2,2,1); 

sub split-same-avg(*@nums)
{
    for (^@nums).combinations(1..@nums.elems div 2) -> @a
    {
        return True if @nums[@a].sum / @nums[@a].elems == @nums.sum / @nums.elems
    }

    return False
}
