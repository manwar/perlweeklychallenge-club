#!/usr/bin/env raku

use Prime::Factor;

say divisors-last-digit(24, 2);
say divisors-last-digit(30, 5);

sub divisors-last-digit(\m, \n)
{
    + divisors(m).grep(*.ends-with(n));
}
