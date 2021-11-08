#!/usr/bin/env raku

use Test;
plan 3;

is square((10, 20), (20, 20),  (20, 10),  (10, 10)),   1;
is square((12, 24), (16, 10),  (20, 12),  (18, 16)),   0;
is square((10, 20), (10, -10), (-20, 20), (-20, -10)), 1;

sub square(**@pts)
{
    @pts .= sort;

    return + (diagonals-equal() and sides-equal());

    sub diagonals-equal
    {
        [==] (@pts[3;0] - @pts[0;0])² + (@pts[3;1] - @pts[0;1])²,
             (@pts[2;0] - @pts[1;0])² + (@pts[2;1] - @pts[1;1])²;
    }

    sub sides-equal
    {
        [==] (@pts[1;0] - @pts[0;0])² + (@pts[1;1] - @pts[0;1])²,
             (@pts[2;0] - @pts[0;0])² + (@pts[2;1] - @pts[0;1])²,
             (@pts[3;0] - @pts[2;0])² + (@pts[3;1] - @pts[2;1])²,
             (@pts[3;0] - @pts[1;0])² + (@pts[3;1] - @pts[1;1])²;
    }
}
