#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0); 

say + ($n.comb.map({ [*] (1 .. $_) }).sum == $n);
