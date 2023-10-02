#!/bin/env raku

unit sub MAIN(*@N where @N.all ≥ 0);

put max-coins(|@N);

multi max-coins($n)     { $n }
multi max-coins($m, $n) { $m * $n + max($m, $n) }

multi max-coins(*@N) {
    gather {
        for 1 ..^ +@N - 1 -> $i {
            my @M = @N.clone;
            @M.splice($i, 1);
            take max-coins(|@M) + [*] @N[$i-1 .. $i+1];
   } }.max
}
