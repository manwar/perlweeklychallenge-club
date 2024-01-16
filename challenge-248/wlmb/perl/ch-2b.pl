#!/usr/bin/env perl
use v5.36;
use PDL;
use PDL::FFT;
my $matrix=pdl(shift);
my $width=my $w=shift;
my $height=my $h=shift;
my $small=ones($w%2?$w:$w+1, $h%2?$h:$h+1);
$small->slice(-1).=0, ++$w unless $w%2; # zero row and/or column for even kernels
$small->slice([],-1).=0, ++$h unless $h%2;
my $kernel=kernctr($matrix, $small); #full kernel
my $result=$matrix->copy;
$result->fftconvolve($kernel);
say "$matrix $width $height -> ",
$result->slice([floor(($width-1)/2),floor(-($width+1)/2)],
	       [floor(($height-1)/2),floor(-($height+1)/2)]);
