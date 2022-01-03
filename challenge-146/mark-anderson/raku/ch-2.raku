#!/usr/bin/env raku

use Test;

is-deeply ancestors(3/5).head(2), (3/2, 1/2);
is-deeply ancestors(4/3).head(2), (1/3, 1/2);

# 14/20 == 7/10 which is a member.
is-deeply ancestors(14/20), (7/3, 4/3, 1/3, 1/2, 1/1); 
is-deeply ancestors(17/20), (17/3, 14/3, 11/3, 8/3, 5/3, 2/3, 2/1, 1/1);
is-deeply ancestors(23/19), (4/19, 4/15, 4/11, 4/7, 4/3, 1/3, 1/2, 1/1);

sub ancestors($rat is copy)
{
    gather until $rat == 1
    {
        $rat = ancestor($rat) andthen .take
    }
}

multi ancestor(\rat where * < 1)
{
    .numerator / (.denominator - .numerator) with rat
}

multi ancestor(\rat)
{
    (.numerator - .denominator) / .denominator with rat
}
