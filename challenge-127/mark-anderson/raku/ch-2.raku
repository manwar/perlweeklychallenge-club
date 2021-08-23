#!/usr/bin/env raku

use Test;
plan 4;

is-deeply conflict-intervals((1,4), (3,5), (6,8), (12,13), (3,20)), [(3,5), (3,20)];
is-deeply conflict-intervals((3,4), (5,7), (6,9), (10,12), (13,15)), [(6,9),];

is-deeply conflict-intervals-v2((1,4), (3,5), (6,8), (12,13), (3,20)), [(3,5), (3,20)];
is-deeply conflict-intervals-v2((3,4), (5,7), (6,9), (10,12), (13,15)), [(6,9),];

sub conflict-intervals(**@i)
{
    .Array given gather
    {
        while @i > 1
        {
            take @i[1] if @i[1].head < @i[0].tail;
            shift @i;
        }
    }
}

sub conflict-intervals-v2(**@i)
{
    @i .= sort;

    .Array given gather
    {
        while @i > 1
        {
            take @i[1] if [<=] flat zip @i[0]<>, @i[1]<>;
            shift @i;
        }
    }
}
