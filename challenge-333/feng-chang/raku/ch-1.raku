#!/bin/env raku

unit sub MAIN(Str:D $points);

use MONKEY-SEE-NO-EVAL;

my (\x1, \y1, \x2, \y2, \x3, \y3) = (EVAL $points).flat;
put so x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2) == 0;
