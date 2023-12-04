#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations subsets);

sub largest_of_three{
  my $res = -1;
  foreach my $i(0..@{$_[0]}){
    foreach my $subset(subsets $_[0],$i){
      foreach my $p(permutations $subset){
        next unless @$p;
        my $n = join '',@$p;
        $res = $n if $n > $res && $n % 3 == 0;
      }
    }
  }
  $res
}

printf "%d\n",largest_of_three([8,1,9]);
printf "%d\n",largest_of_three([8,6,7,1,0]);
printf "%d\n",largest_of_three([1]);

