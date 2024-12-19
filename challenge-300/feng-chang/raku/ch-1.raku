#!/bin/env raku

unit sub MAIN(UInt:D $n);

put +(1..$n).permutations.grep(-> @a { @a.kv.rotor(2).map({ (.[0]+1) %% .[1] || .[1] %% (.[0]+1) }).all });
