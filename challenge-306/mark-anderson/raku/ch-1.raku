#!/usr/bin/env raku
use Test;

is odd-sum(2,5,3,6,4), 77;
is odd-sum(1,3),        4;

sub odd-sum(+@ints)
{
    sum flat (1,3...@ints.elems).map(-> $n { @ints.rotor($n => -$n+1) })
}
