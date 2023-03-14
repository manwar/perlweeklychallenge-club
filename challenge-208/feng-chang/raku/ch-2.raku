#!/bin/env raku

unit sub MAIN(*@N);

put "Duplicate: { @N.Bag.grep({ .value > 1 }).Hash.keys || 'null' } and ",
    "Missing: { ((@N[0] .. +@N) (-) @N».Int)            || 'null' }";
