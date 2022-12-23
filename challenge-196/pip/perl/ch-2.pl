#!/usr/bin/perl
# Given a sorted unique integer array, find all possible Number Range i.e., [x,y] representing range from x and y (both inclusive).
# Example 1: Each subsequence of 2 or more contiguous integers
#   In-put: @array = (1,3,4,5,7)
#   Output: [3,5]
# Example 2:
#   In-put: @array = (1,2,3,6,7,9)
#   Output: [1,3], [6,7]
# Example 3:
#   In-put: @array = (0,1,2,4,5,6,8,9)
#   Output: [0,2], [4,6], [8,9]
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCMLCLen';
sub NumR {my @iary=@_;my $mult=0;my @oary=();my $i=0; # Last week, I treated output comments as to be printed.
  print '(' . sprintf("%-15s",join(',',@iary)) . ') => '; # This week, I just print input.
  while  ($i < $#iary){my $strt=$i;
    while($i < $#iary  && $iary[$i+1] == ($iary[$i] + 1)){$i++;}
    if($strt != $i){
      print ', ' if($mult);
      print "[$iary[$strt],$iary[$i]]";$mult=1;push(@oary,[$iary[$strt],$iary[$i]]);
    } $i++;
  } say ";";
  return(@oary);
}
if(@ARGV){
  NumR(@ARGV);
}else{
  NumR(1,3,4,5,7);
  NumR(1,2,3,6,7,9);
  NumR(0,1,2,4,5,6,8,9);
}
