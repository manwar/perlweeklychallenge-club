#!/usr/bin/env raku
use Test;

is-deeply MAD(4,1,2,3),     [(1,2),(2,3),(3,4)];
is-deeply MAD(1,3,7,11,15), [(1,3),];
is-deeply MAD(1,5,3,8),     [(1,3),(3,5)];

sub MAD(+@ints)
{
    @ints.sort
         .rotor(2 => -1)
         .classify({ .[1] - .[0] })
         .min
         .value
}
