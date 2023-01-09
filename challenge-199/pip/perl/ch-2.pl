#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl Weekly Challenge #2 of Week #199 - Pip Stuart
# Good Triplets: You are given an array of integers, @array and three integers $x,$y,$z.
#   Write a script to find out total Good Triplets in the given array.
#     A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:
#   a) 0 <= i < j < k <= n (size of given array)
#   b) abs(array[i] - array[j]) <= x
#   c) abs(array[j] - array[k]) <= y
#   d) abs(array[i] - array[k]) <= z
# Example1:
#   In-put: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
#   Output: 4
# Example2:
#   In-put: @array = (1,1,2,2,3  ) and $x = 0, $y = 0, $z = 1
#   Output: 0
# Note: I'm taking the liberty to accept x, y, z ahead of array.
use strict;use warnings;use utf8;use v5.10;my $d8VS='N19LHOLD';
sub GdTr {my $x=shift;my $y=shift;my $z=shift;my @aray=@_;my @trpz=();
  print sprintf("x=%d y=%d z=%d a=%-11s",$x,$y,$z,join(',',@aray)) . ' => ';
  for           (   0..$#aray-2){
    for   my $j ($_+1..$#aray-1){
      for my $k ($j+1..$#aray  ){
        if(abs($aray[$_]-$aray[$j]) <= $x &&
           abs($aray[$j]-$aray[$k]) <= $y &&
           abs($aray[$_]-$aray[$k]) <= $z){push(@trpz,[$_,$j,$k]);}}}}
  say scalar(@trpz) . ';';
  return    (@trpz);
}
if(@ARGV){
  GdTr(@ARGV);
}else{ #xyz
  GdTr(7,2,3, 3,0,1,1,9,7); # => 4;
  GdTr(0,0,1, 1,1,2,2,3  ); # => 0;
}
