#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl Weekly Challenge #1 of Week #199 - Pip Stuart
# Good Pairs: Given a list of integers, @list. Write a script to find the total count of Good Pairs.
#   A pair (i,j) is called good if list[i] == list[j] and i < j.
# Example1:
#   In-put: @list = (1,2,3,1,1,3)
#   Output:          4
# Example2:
#   In-put: @list = (1,2,3      )
#   Output:          0
# Example3:
#   In-put: @list = (1,1,1,1    )
#   Output:          6
use strict;use warnings;use utf8;use v5.10;my $d8VS='N19LHJac';
sub GdPr {my @list=@_;my @parz=();
  print '(' . sprintf("%-11s",join(',',@list)) . ') => ';
  for(0..$#list-1){
    for my $j ($_+1..$#list){
      if($list[$_] == $list[$j]){push(@parz,[$_,$j]);}}
  } say  scalar(@parz) . ';';
  return       (@parz);
}
if(@ARGV){
  GdPr(@ARGV);
}else{
  GdPr(1,2,3,1,1,3); # => 4;
  GdPr(1,2,3      ); # => 0;
  GdPr(1,1,1,1    ); # => 6;
}
