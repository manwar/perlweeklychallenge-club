#!/usr/bin/env perl
use strict;
use warnings;

sub matching_numbers
{
  my @sorted = sort{$a <=> $b} @{$_[0]};
  my $sum = 0;
  for(my $i = 0; $i < @sorted; ++$i)
  {
    $sum++ if($_[0]->[$i] == $sorted[$i])
  }
  $sum
}

printf "%d\n", matching_numbers([1,1,4,2,1,3]);
printf "%d\n", matching_numbers([5,1,2,3,4]);
printf "%d\n", matching_numbers([1,2,3,4,5]);

