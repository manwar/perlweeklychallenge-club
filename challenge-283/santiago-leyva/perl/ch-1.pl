=begin
You are given an array of integers, @ints, where every elements appears more than once except one element.

Write a script to find the one element that appears exactly one time.

Example 1
Input: @ints = (3, 3, 1)
Output: 1
Example 2
Input: @ints = (3, 2, 4, 2, 4)
Output: 3
Example 3
Input: @ints = (1)
Output: 1
Example 4
Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3
=cut
use strict;
use Data::Dumper;


my @inputs = ([3, 3, 1],[3, 2, 4, 2, 4],[1],[4, 3, 1, 1, 1, 4]);

foreach(@inputs){
  my $arr = $_;
  my @A = @$arr;
  my $result = findUnique(\@A);
  print $result."\n";
}

sub findUnique {
  my $array = shift;
  my @nums = @$array;
  my %seen;
  my %deleted;
  foreach(@nums){

    if(exists($seen{$_})){
      $seen{$_} += 1;
      $deleted{$_} = 1;
      delete $seen{$_};
    }else{
      if(!exists($deleted{$_})){
        $seen{$_} = 1;
      }
    }
  }

  my @values = keys %seen;

  return $values[0] if (@values);
  return -1;
  
}