#!/usr/bin/perl
use strict;
use integer;

# All integers with the pattern _ABAB_ is gapful(_AB_*101) and there are 10*9/2 + 9 = 54 (A runs from 0 to 9, B runs from 0 to 9, 0000 is not counted) such integers. In short, all 20 first >= 100 gapful numbers are larger than 99 and smaller than 9999.


my $th;

my $c = 0; 

for my $N (100..999) {

	$th = 10 * int($N / 100) + ($N % 10);

	if ($N % $th == 0) {$c++; print $c, ". ", $N , "\n";}

	if ($c==20) {exit;}
}


for my $N (1000..9999) {

	$th = 10 * int($N / 1000) + ($N % 10);

	if ($N % $th == 0) {$c++; print $c, ". ", $N , "\n";}

	if ($c==20) {exit;}
}
