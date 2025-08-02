#!/bin/env raku

unit sub MAIN($n where * > 0);

put solve($n, 1).join(' ');

multi solve(0, $)   { () }
multi solve(1, $)   { 0 }
multi solve($n, $i) { $i, -$i, |solve($n-2, $i+1) }
