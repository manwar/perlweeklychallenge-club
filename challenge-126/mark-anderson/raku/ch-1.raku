#!/usr/bin/env raku

use Test;
plan 2;

is count-numbers(15), 8;
is count-numbers(25), 13;

sub count-numbers($N)
{
    + grep { not .contains: 1 }, 1..$N;
}
