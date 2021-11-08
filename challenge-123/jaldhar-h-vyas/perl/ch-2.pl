#!/usr/bin/perl
use 5.020;
use warnings;

my ($x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4) = @ARGV;

say 0+(abs($x1 - $x3) == abs($x2 - $x4) && abs($y1 - $y2) == abs($y3 - $y4)) ? 1 : 0;
