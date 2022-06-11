#!/usr/bin/env raku

# This doesn't work for all numbers but it's a start.

use Prime::Factor;

say (2..79).map(&home-prime);

multi home-prime($n where $n == 49|77) { Any }

multi home-prime($n is copy)
{
    $n = prime-factors($n).join.Int;
    return $n if $n.is-prime;
    home-prime($n)
}    
