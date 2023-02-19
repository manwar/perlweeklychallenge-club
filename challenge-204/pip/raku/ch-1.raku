#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #204 - Pip Stuart
# Task1: Monotonic Array:  Submitted by: Mohammad S Anwar;  You are given an array of integers.
#   Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
# An array is Monotonic if it is either monotone increasing or decreasing.
#   Monotone increasing: for i <= j , nums[i] <= nums[j]
#   Monotone decreasing: for i <= j , nums[i] >= nums[j]
# Example1:
#   In-put: @nums = (1,2,2,3)
#   Output:          1
# Example2:
#   In-put: @nums = (1,3,2  )
#   Output:          0
# Example3:
#   In-put: @nums = (6,5,5,4)
#   Output:          1
use v6;my $d8VS='N2GL078C';
sub Mono {my @nums=@_;my $frsf=0;my $monf=1;my $strt=1;
  $strt++ while (@nums && $strt < @nums.elems-1 && @nums[$strt-1] == @nums[$strt]);
  if  (@nums.elems > 1) { $frsf= (@nums[$strt-1] > @nums[$strt]) ?? -1 !! 1; }
  for ($strt..@nums.elems-2) {
    if (($frsf == -1 && @nums[$_] < @nums[$_+1]) ||
        ($frsf ==  1 && @nums[$_] > @nums[$_+1])) { $monf=0;last; } }
  print '(' ~ sprintf("%-7s",join(',',@nums)) ~ ') => ';
  say    $monf ~ ';';
  return($monf);
}
if    (@*ARGS) {
  Mono(@*ARGS);
} else {
  Mono(1,2,2,3); # => 1
  Mono(1,3,2  ); # => 0
  Mono(6,5,5,4); # => 1
}
