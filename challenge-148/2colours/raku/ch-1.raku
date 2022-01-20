#!/usr/bin/env raku

constant @small-contains-e = 1, 3, 5, 7, 8, 9, 10, 11, 12;
constant @xties-contains-e = 2, 7, 8, 9;
multi is-eban($num where 0 < * <= 12) { $num !(elem) @small-contains-e }
multi is-eban($num where 13 <= * < 20) { False }
multi is-eban($num where 20 <= * < 100) { $num div 10 !(elem) @xties-contains-e and $num%%10 || is-eban($num%10) }

say (1..^100).grep(&is-eban);
