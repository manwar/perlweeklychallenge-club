#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

my @N is Array = EVAL $s;

for ^+@N -> $j {
    @N[$j] = @N[$j].map({ 1 - $_ }).Array if @N[$j;0] == 0;
}

for ^+@N[0] -> $j {
    @N[*;$j] = @N[*;$j].map({ 1 - $_ }).Array if @N[*;$j].sum < +@N/2;
}

put @N.map({ .join.parse-base(2) }).sum;
