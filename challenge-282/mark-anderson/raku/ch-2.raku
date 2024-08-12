#!/usr/bin/env raku
use Test;

is changing-keys("pPeERrLl"),                      3;
is changing-keys("rRr"),                           0;
is changing-keys("GoO"),                           1;
is changing-keys("ILooooooVeEEpppPErrrrrLLLLlLL"), 8;

sub changing-keys($str)
{
    $str.lc.comb.squish.elems - 1
}
