#!/usr/bin/env raku

use Prime::Factor;
use Test;
plan 2;

is-deeply number-divisors(8)[^10], 
          (24, 30, 40, 42, 54, 56, 66, 70, 78, 88), 'example 1';

is-deeply number-divisors(8)[^10000].tail(5), 
          (45626, 45627, 45638, 45642, 45646), 'hyper ftw!';

sub number-divisors(\n)
{
    (^Inf).hyper.grep({ divisors($_) == n });
}
