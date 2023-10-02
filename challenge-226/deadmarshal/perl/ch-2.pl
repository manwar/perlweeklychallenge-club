#!/usr/bin/env perl
use strict;
use warnings;

sub zero_array
{
  my %hash = map{$_ => 1} grep {$_} @{$_[0]};
  scalar %hash
}

printf "%d\n", zero_array([1,5,0,3,5]);
printf "%d\n", zero_array([0]);
printf "%d\n", zero_array([2,1,4,0,3]);

