#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(variations_with_repetition);

sub floor_sum{
  my $it = variations_with_repetition($_[0],2);
  my $sum = 0;
  while(my $c = $it->next){
    $sum += int($c->[0] / $c->[1]);
  }
  $sum
}

printf "%d\n",floor_sum([2,5,9]);
printf "%d\n",floor_sum([7,7,7,7,7,7,7]);

