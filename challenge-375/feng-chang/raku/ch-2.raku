#!/bin/env raku

unit sub MAIN(UInt:D $num, UInt:D $k);

put +$num.comb.rotor($k => 1-$k).grep({ $num %% .join });
