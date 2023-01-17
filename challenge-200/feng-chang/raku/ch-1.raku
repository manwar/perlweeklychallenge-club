#!/bin/env raku

unit sub MAIN(*@N);

.put for (^+@N X ^+@N)
    .grep({ .[1] - .[0] > 1 })
    .grep({ [==] (.[0] ..^ .[1]).map({ @N[$_+1] - @N[$_] }) })
    .map({ "({ @N[.[0] .. .[1]].join(', ') })" });
