#!/bin/env raku

unit sub MAIN(Str:D $points);

use MONKEY-SEE-NO-EVAL;

my ($x, $y, @points) = EVAL $points;
with @points.map({ ($x==.[0] || $y==.[1]) ?? abs(.[0]-$x) + abs(.[1]-$y) !! Inf }).min(:p).head {
    put .value != Inf ?? .key !! -1;
}
