#!/usr/bin/env raku

use Test;
plan 2;

is-deeply conflict-intervals((1,4), (3,5), (6,8), (12, 13), (3,20)), [(3,5), (3,20)];
is-deeply conflict-intervals((3,4), (5,7), (6,9), (10, 12), (13,15)), [(6,9),];

sub conflict-intervals(**@intervals)
{
    gather
    {
        while @intervals > 1
        {
            if @intervals[1].head < @intervals[0].tail
            {
                take @intervals[1];
            }

            @intervals.shift;
        }
    }.Array;
}
