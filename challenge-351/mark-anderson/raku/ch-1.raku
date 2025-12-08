#!/usr/bin/env raku
use Test;

is special-average(8000,5000,6000,2000,3000,7000), 5250;
is special-average(100_000,80_000,110_000,90_000), 95_000;
is special-average(2500,2500,2500,2500),           0;
is special-average(2000),                          0;
is special-average(1000,2000,3000,4000,5000,6000), 3500;
is special-average(1000,2000),                     0;
is special-average(1000,2000,4000),                2000;
is special-average(80,80,20,50,50,30,60,20,20,30), 44;

sub special-average(*@i)
{
    my @k = (@i.keys (-) (@i.min(:k), @i.max(:k)).flat(:hammer)).keys;
    @i[@k].sum / (@i[@k] || 1)
}
