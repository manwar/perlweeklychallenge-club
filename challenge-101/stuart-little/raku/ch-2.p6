#!/usr/bin/env perl6
use v6;

# run <script> <x1 y1 x2 y2 x3 y3>

sub areaTr($x1,$y1,$x2,$y2,$x3,$y3) {
    ((($y3-$y1)*($x2-$x1) - ($y2-$y1)*($x3-$x1)).abs)/2
}

my ($x1,$y1,$x2,$y2,$x3,$y3) = @*ARGS[0..5].map(*.Int);

say (areaTr(0,0,$x1,$y1,$x2,$y2) + areaTr(0,0,$x2,$y2,$x3,$y3) + areaTr(0,0,$x3,$y3,$x1,$y1) == areaTr($x1,$y1,$x2,$y2,$x3,$y3)).Int;
