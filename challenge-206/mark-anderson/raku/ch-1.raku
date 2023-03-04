#!/usr/bin/env raku
use Test;

is shortest-time(< 00:00 23:55 20:00 >),        5;
is shortest-time(< 01:01 00:50 00:57 >),        4;
is shortest-time(< 10:10 09:30 09:00 09:55 >), 15;

sub shortest-time(@a)
{
    min map 
    {
        my @t = .map({ .split(':').List })
                .map({ .[0] * 60 + .[1] });

        ((.min, .min + 1440) >>->> .max)>>.abs.min given @t
    }, 
    @a.combinations(2)
}
