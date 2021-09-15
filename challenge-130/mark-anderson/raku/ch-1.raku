#!/usr/bin/env raku

use Test;
plan 2;

is odd-number(2, 5, 4, 4, 5, 5, 2), 5;
is odd-number(1, 2, 3, 4, 3, 2, 1, 4, 4), 4;

sub odd-number(**@N)
{
    .key with @N.Bag.first({ .value % 2 }); 
}
