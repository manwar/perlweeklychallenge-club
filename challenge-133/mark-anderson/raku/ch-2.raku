#!/usr/bin/env raku

use Prime::Factor;

sub smith-number($n)
{
    return False if $n.is-prime;
    my @n = $n.comb;
    my @p = prime-factors($n).map(*.comb).flat;
    return @n.sum == @p.sum;
}

say .[^10] given (1..*).grep(&smith-number);
