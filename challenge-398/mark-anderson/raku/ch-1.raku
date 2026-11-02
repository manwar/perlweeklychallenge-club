#!/usr/bin/env raku
use Test;

is div-avg(18,5,7,11),        18;
is div-avg(6,12,18,24,30,40), 18;
is div-avg(3,9,15,21,27),      0;
is div-avg(6,12,14,20),        9;
is div-avg(6,6,6,12,12),       8;

sub div-avg(*@arr)
{
    my $b = @arr.BagHash; 
    my $k = ($b.keys (-) (6,12,18...@arr.max)).keys; 
    quietly $b{$k.flat} = 0;
    round ($b.kxxv.sum / ($b.total || 1))
}
