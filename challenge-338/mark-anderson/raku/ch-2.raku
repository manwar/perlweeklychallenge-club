#!/usr/bin/env raku
use Test;

is max-distance((4,5,7),    (9,1,3,4)),     6;
is max-distance((2,3,5,4),  (3,2,5,5,8,7)), 6;
is max-distance((2,1,11,3), (2,5,10,2)),    9;
is max-distance((1,2,3),    (3,2,1)),       2;
is max-distance((1,0,2,3),  (5,0)),         5;

sub max-distance(@a, @b)
{
    my ($min-a, $max-a) = @a.minmax[0,*-1];
    my ($min-b, $max-b) = @b.minmax[0,*-1];

    max $max-a - $min-b, $max-b - $min-a
}
