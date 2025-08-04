#!/usr/bin/env raku
use Test;

ok  straight-line([2,1], [2,3], [2,5]);
ok  straight-line([1,4], [3,4], [10,4]);
nok straight-line([0,0], [1,1], [2,3]);
ok  straight-line([1,1], [1,1], [1,1]);
ok  straight-line([1000000,1000000], [2000000,2000000], [3000000,3000000]);

sub straight-line(+@points)
{
    [==] @points.rotor(2 => -1).flat.map(&slope)
}

sub slope(@a, @b) 
{ 
    my $m = (@b[1] - @a[1]) / (@b[0] - @a[0]);
    $m.denominator ?? $m !! Inf
}
