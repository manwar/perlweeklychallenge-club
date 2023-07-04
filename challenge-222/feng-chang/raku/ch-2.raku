#!/bin/env raku

unit sub MAIN(*@N where @N.all > 0);

@N = +«@N;

while +@N > 1 {
    my \ndx-a = @N.first(@N.max, :k);
    my (\a) = @N.splice(ndx-a, 1);      # No. 1

    my \ndx-b = @N.first(@N.max, :k);
    my (\b) = @N.splice(ndx-b, 1);      # No. 2

    my \d = a - b;
    @N.splice(ndx-a - (ndx-a > ndx-b), 0, d) if d;
    #put "pick {a} and {b} => ({@N.join(', ')})";
}

put +@N ?? @N[0] !! 0;
