#!/usr/bin/env raku
use Test;

is count-prime(10), 4;
is count-prime(1),  0;
is count-prime(20), 8;

multi count-prime($n where * < 2) { 0 }

multi count-prime($n)
{
    (2,3,5,7...$n).grep(&is-prime).elems
}
