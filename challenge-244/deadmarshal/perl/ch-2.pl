#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use Algorithm::Combinatorics qw(subsets);

sub group_hero{
  my $sum = 0;
  my $it = subsets($_[0]);
  while(my $c = $it->next){
    $sum += (max(@$c) ** 2) * min(@$c) if @$c;
  }
  $sum
}

printf "%d\n", group_hero([2,1,4]);

