#!/usr/bin/env perl
use strict;
use warnings;

sub summations{
  my ($arr) = @_;
  my ($i,$j);
  for($i = 0; $i < @$arr; ++$i){
    for($j = $i+1; $j < @$arr-1; ++$j){
      $arr->[$j+1] = $arr->[$j] + $arr->[$j+1];
    }
  }
  return $arr->[$j-1];
}

my @arr = (1,2,3,4,5);
my @arr2 = (1,3,5,7,9);
print summations(\@arr), "\n";
print summations(\@arr2), "\n";

