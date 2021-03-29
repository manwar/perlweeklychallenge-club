#!/usr/bin/env raku

use Test;
plan 3;

is max-gap(2, 9, 3, 5),    4;
is max-gap(1, 3, 8, 2, 0), 5;
is max-gap(5),             0;

multi max-gap($N)  { 0 }

multi max-gap(*@N) { max @N.sort.rotor(2 => -1).map({ .[1] - .[0] }) }
