#!/usr/bin/env perl
# Perl weekly challenge 298
# Task 1:  Maximal Square
#
# See https://wlmb.github.io/2024/12/02/PWC298/#task-1-maximal-square
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    to find the area of the largest submatrix of ones within
    each of the binary matrices M1 M2...
    Mi is a string that describes a PDL ndarray, such as
    "[[X00 X01...][X10 X11...][...]...]"
    FIN
for(@ARGV){
    my $matrix=pdl($_);
    my ($size_x, $size_y)=$matrix->dims;
    my $max=0;
    my $sm=pdl[[]];
    for my $x(0..$size_x-1){
      ROW: for my $y(0..$size_y-1){
	  for my $size(0..$matrix->dim(0)-1-$x){
	      next ROW if $size+$y>=$matrix->dim(1)
		  ||!($matrix($x:$x+$size,$y+$size)->all&& $matrix($x+$size,$y:$y+$size)->all);
	      ++$max, if $max<=$size;
	  }
      }
    }
    say "$matrix -> ", $max**2;
}
