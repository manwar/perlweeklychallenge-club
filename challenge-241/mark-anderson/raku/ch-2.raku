#!/usr/bin/env raku
use Prime::Factor;
use Test;

is-deeply prime-order(11,8,27,4), (11,4,8,27);

sub prime-order
{
    @_.sort({ prime-factors($_).elems, $_ })  
}
