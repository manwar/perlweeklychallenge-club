#!/usr/bin/env perl
use strict;
use warnings;

sub max_diff{
  my ($arr) = @_;
  @$arr = sort{$a <=> $b} @$arr;
  $arr->[-1] * $arr->[-2] - $arr->[0] * $arr->[1]
}

printf "%d\n",max_diff([5,9,3,4,6]);
printf "%d\n",max_diff([1,-2,3,-4]);
printf "%d\n",max_diff([-3,-1,-2,-4]);
printf "%d\n",max_diff([10,2,0,5,1]);
printf "%d\n",max_diff([7,8,9,10,10]);

