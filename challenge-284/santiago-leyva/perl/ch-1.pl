=begin 
You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.

A lucky integer is an integer that has a frequency in the array equal to its value.

Example 1
Input: @ints = (2, 2, 3, 4)
Output: 2
Example 2
Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3
Example 3
Input: @ints = (1, 1, 1, 3)
Output: -1
=cut

use strict;
use Data::Dumper;


my @inputs = ([2, 2, 3, 4],[1, 2, 2, 3, 3, 3],[1, 1, 1, 3]);

foreach(@inputs){
  my $arr = $_;
  my @A = @$arr;
  my $result = luckyNumber(\@A);
  print $result."\n";
}

sub luckyNumber {
  my $array = shift;
  my @nums = @$array;

  my %set;

  foreach(@nums){
    if(exists($set{$_})){
      $set{$_} += 1;
    }else{
      $set{$_} = 1;
    }
  }
  
  my @largest;
  foreach(sort {$a <=> $b} keys %set){
    if($set{$_} == $_){
      push @largest,$_;
    }
  }

  return $largest[-1] if (@largest);
  return -1;

}