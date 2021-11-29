#!/usr/bin/env raku

use Prime::Factor;

say (^Inf).race.grep({ divisors($_) == 8 })[^10];
