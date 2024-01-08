#!/usr/bin/env perl
use v5.36;
use PDL;
use PDL::Image2D;
die <<~"FIN" unless @ARGV==3;
    Usage: $0 M W H
    where M is a matrix "[[m11,m22...],[m21,m22....],...]"
    and W and H are the size of a sliding window to make a matrix of HxW submatrices
    and sum the submatrix matrix elements.
    FIN
my $m=pdl(shift);
my $w=shift;
my $h=shift;
say "Input: $m Width $w, Height $h -> ",
    $m->conv2d(ones($w,$h))->slice([floor(($w-1)/2),floor(-($w+1)/2)],
				   [floor(($h-1)/2),floor(-($h+1)/2)]);
