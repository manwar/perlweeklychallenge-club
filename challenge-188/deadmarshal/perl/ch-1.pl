#!/usr/bin/env perl
use strict;
use warnings;

sub divisible_pairs{
  my ($arr, $k) = @_;
  my $count = 0;
  for(my $i = 0; $i < @$arr; ++$i){
    for(my $j = $i+1; $j < @$arr; ++$j){
      $count++ if($arr->[$i] + $arr->[$j]) % $k == 0;
    }
  }
  $count;
}

print divisible_pairs([4,5,1,6], 2), "\n";
print divisible_pairs([1,2,3,4], 2), "\n";
print divisible_pairs([1,3,4,5], 3), "\n";
print divisible_pairs([5,1,2,3], 4), "\n";
print divisible_pairs([7,2,4,5], 4), "\n";

