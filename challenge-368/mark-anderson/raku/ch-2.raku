#!/usr/bin/env raku
use Prime::Factor;
use Test;

is big-and-little-omega(100061, 0), 3;
is big-and-little-omega(971088, 0), 3;
is big-and-little-omega(63640,  1), 6;
is big-and-little-omega(988841, 1), 2;
is big-and-little-omega(211529, 0), 2;

sub big-and-little-omega($number, $mode)
{
    return prime-factors($number).elems if $mode;
    return prime-factors($number).squish.elems
}
