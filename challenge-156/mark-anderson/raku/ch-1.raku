#!/usr/bin/env raku

use Test;

is-deeply (1..*).grep(&pernicious).head(10), (3, 5, 6, 7, 9, 10, 11, 12, 13, 14);

sub pernicious($n)
{
    $n.base(2).comb.sum.is-prime
}  
