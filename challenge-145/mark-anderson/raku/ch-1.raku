#!/usr/bin/env raku

use Test;

is dot-product((1, 2, 3), (4, 5, 6)), 32;
is dot-product((1, 2, 3, 4), (4, 5, 6, 7), (7, 8, 9, 1)), 298;
is dot-product((1, 2, 3, 4), (4, 5, 6, 7), (7, 8, 9, 1), (2, 3, 4, 5)), 1084;

sub dot-product(+@a)
{
    sum [>>*<<] @a; 
}
