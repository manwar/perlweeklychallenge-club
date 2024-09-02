#!/usr/bin/env raku
use Test;

is lucky-integer(2,2,3,4),      2;
is lucky-integer(1,2,2,3,3,3),  3;
is lucky-integer(1,1,1,3),     -1;

sub lucky-integer(+@int)
{
    try { @int.Bag.grep({ .key == .value }).max.value } // -1
}
