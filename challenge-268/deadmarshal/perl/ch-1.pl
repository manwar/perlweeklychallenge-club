#!/usr/bin/env perl
use strict;
use warnings;

sub magic_number{
  my @x = sort{$a <=> $b} @{$_[0]};
  my @y = sort{$a <=> $b} @{$_[1]};
  abs($x[0] - $y[0])
}

printf "%d\n",magic_number([3,7,5],[9,5,7]);
printf "%d\n",magic_number([1,2,1],[5,4,4]);
printf "%d\n",magic_number([2],[5]);

