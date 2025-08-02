#!/bin/env raku

unit sub MAIN(Str:D $points-str);

use MONKEY-SEE-NO-EVAL;
my \p = (EVAL $points-str).Array;
put so (p[1;0]-p[0;0])*(p[2;1]-p[0;1])-(p[1;1]-p[0;1])*(p[2;0]-p[0;0]);
