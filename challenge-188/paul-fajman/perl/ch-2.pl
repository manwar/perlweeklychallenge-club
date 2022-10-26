#!/usr/bin/perl

# Weekly Challenge 188 Task #2
# You are given two positive integers $x and $y.
# 
# Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:
#
# $x = $x - $y if $x >= $y
# 
# or
# 
# $y = $y - $x if $y >= $x (using the original value of $x)
###############################

use strict;
use warnings;

my @x = (5,4,2,3,7);
my @y = (4,6,5,1,4);
my ($count, $i);

for ($i = 0; $i<$#x+1; $i++) {
  print "Input: \$x = $x[$i], \$y = $y[$i]\n";
  while ($x[$i] > 0 && $y[$i] > 0) {
    if ($x[$i] >= $y[$i]) {
      $x[$i] = $x[$i] - $y[$i];
    }
    elsif ($y[$i] >= $x[$i]) {
      $y[$i] = $y[$i] - $x[$i]
    }
    $count++;
  }
  print "Output: $count\n\n";
  undef($count);
}
