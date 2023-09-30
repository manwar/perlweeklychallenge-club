#!/usr/bin/env perl
use strict;
use warnings;

sub array_loops{
  my ($count,@indices) = (0);
  foreach my $i(0..$#{$_[0]}){
    next if $indices[$i];
    $count++;
    while(!$indices[$i]){
      $indices[$i] = 1;
      $i = $_[0]->[$i];
    }
  }
  $count
}

printf "%d\n",
  array_loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10]);
printf "%d\n",
  array_loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19]);
printf "%d\n",
  array_loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17]);

