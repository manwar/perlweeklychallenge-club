#!/usr/bin/env perl
use strict;
use warnings;

sub running_sum{
  my $sum = 0;
  map{$sum += $_[0]->[$_]} 0..$#{$_[0]}
}

printf "(%s)\n",join ',',running_sum([1,2,3,4,5]);
printf "(%s)\n",join ',',running_sum([1,1,1,1,1]);
printf "(%s)\n",join ',',running_sum([0,-1,1,2]);

