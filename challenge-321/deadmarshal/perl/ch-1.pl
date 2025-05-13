#!/usr/bin/env perl
use strict;
use warnings;

sub distinct_average{
  my @arr = sort{$a <=> $b} @{$_[0]};
  my %h;
  undef $h{($arr[$_] + $arr[$#arr-$_]) / 2} foreach 0..@arr/2;
  scalar keys %h
}

printf "%d\n",distinct_average([1,2,4,3,5,6]);
printf "%d\n",distinct_average([0,2,4,8,3,5]);
printf "%d\n",distinct_average([7,3,1,0,5,9]);

