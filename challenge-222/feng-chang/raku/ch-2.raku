#!/bin/env raku

unit sub MAIN(*@N where @N.all > 0);

@N = +«@N;

while +@N > 1 {
    my (\a) = @N.splice((^+@N).pick, 1);
    my (\b) = @N.splice((^+@N).pick, 1);
    my \d = abs(b - a);
    @N.splice((^(+@N+1)).pick, 0, d) if d;

    put "pick {a} and {b} => ({@N.join(', ')})";
}

put +@N ?? @N[0] !! 0;
