#!/bin/env raku

unit sub MAIN(UInt:D $x, UInt:D $y, UInt:D $z, *@N);

put (^+@N).combinations(3).grep({
    abs(@N[.[0]] - @N[.[1]]) ≤ $x &&
    abs(@N[.[1]] - @N[.[2]]) ≤ $y &&
    abs(@N[.[2]] - @N[.[0]]) ≤ $z
}).elems;
