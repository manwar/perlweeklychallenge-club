#!/usr/bin/env raku
use Test;

is concat-val([6,12,25,1]),     1286;
is concat-val([10,7,31,5,2,2]), 489;
is concat-val([1,2,10]),        112;

sub concat-val(@a)
{
    sum do while @a { @a.shift ~ (@a.pop || Empty) } 
}
