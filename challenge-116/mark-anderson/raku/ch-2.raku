#!/usr/bin/env raku

use Test;
plan 3;

is sum-of-squares(34), 1;
is sum-of-squares(50), 1;
is sum-of-squares(52), 0;

sub sum-of-squares($N)
{
    +($N.comb.map(* ** 2).sum.sqrt.narrow ~~ UInt);
}
