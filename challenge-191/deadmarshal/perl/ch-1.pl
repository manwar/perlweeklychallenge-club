#!/usr/bin/env perl
use strict;
use warnings;

sub twice_largest{
  my ($arr) = @_;
  @$arr = sort {$b <=> $a} @$arr;
  $arr->[0] >= (2 * $arr->[1]) ? 1 : -1;
}

printf "%2d\n", twice_largest([1,2,3,4]);
printf "%2d\n", twice_largest([1,2,0,5]);
printf "%2d\n", twice_largest([2,6,3,1]);
printf "%2d\n", twice_largest([4,5,2,3]);

