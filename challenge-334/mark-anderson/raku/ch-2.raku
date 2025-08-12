#!/usr/bin/env raku
use Test;

is nearest-valid-point(3, 4, [1,2], [3,1], [2,4], [2,3]),  2;
is nearest-valid-point(2, 5, [3,4], [2,3], [1,5], [2,5]),  3;
is nearest-valid-point(1, 1,        [2,2], [3,3], [4,4]), -1;
is nearest-valid-point(0, 0, [0,1], [1,0], [0,2], [2,0]),  0;
is nearest-valid-point(5, 5, [5,6], [6,5], [5,4], [4,5]),  0;

is nearest-valid-point-maybe(3, 4, [1,2], [3,1], [2,4], [2,3]),  2;
is nearest-valid-point-maybe(2, 5, [3,4], [2,3], [1,5], [2,5]),  3;
is nearest-valid-point-maybe(1, 1,        [2,2], [3,3], [4,4]), -1;
is nearest-valid-point-maybe(0, 0, [0,1], [1,0], [0,2], [2,0]),  0;
is nearest-valid-point-maybe(5, 5, [5,6], [6,5], [5,4], [4,5]),  0;

sub nearest-valid-point($x, $y, +@points)
{
    sub distance($p)
    {
        $p.key => abs($x - $p.value[0]) + abs($y - $p.value[1]) 
    }

    my @mins = @points.grep({ any $x == .[0], $y == .[1] }, :p)
                      .map(&distance)
                      .Map
                      .minpairs;

    @mins ?? @mins.min(:by(*.key)).key !! -1
}

# this seems to work but I'm not sure it should
sub nearest-valid-point-maybe($x, $y, +@points)
{
    sub distance($p)
    {
        abs($x - $p.value[0]) + abs($y - $p.value[1]) => $p.key  
    }

    try return @points.grep({ any $x == .[0], $y == .[1] }, :p)
                      .map(&distance)
                      .min
                      .value;

    return -1
}
