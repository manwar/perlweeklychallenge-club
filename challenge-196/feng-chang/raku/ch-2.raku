#!/bin/env raku

unit sub MAIN(*@N);

@N = @N».Int;
my @ndx = (^+@N X ^+@N)
    .grep({ .[0] < .[1] })
    .grep({
        all(@N[.[0]]..@N[.[1]]) (elem) @N                         and
        (.[0] == 0     or .[0] > 0     and @N[.[0]]-1 !(elem) @N) and
        (.[1] == +@N-1 or .[1] < +@N-1 and @N[.[1]]+1 !(elem) @N)
    });
put @ndx.map({ "[{@N[.[0]]},{@N[.[1]]}]" }).join(', ');
