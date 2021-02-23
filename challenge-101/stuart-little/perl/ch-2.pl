#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <x1 y1 x2 y2 x3 y3>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub areaTr2($x1,$y1,$x2,$y2,$x3,$y3) {
    abs(($y3-$y1)*($x2-$x1) - ($y2-$y1)*($x3-$x1))
}

my ($x1,$y1,$x2,$y2,$x3,$y3) = @ARGV[0..5];

say 0+(areaTr2(0,0,$x1,$y1,$x2,$y2) + areaTr2(0,0,$x2,$y2,$x3,$y3) + areaTr2(0,0,$x3,$y3,$x1,$y1) == areaTr2($x1,$y1,$x2,$y2,$x3,$y3));
