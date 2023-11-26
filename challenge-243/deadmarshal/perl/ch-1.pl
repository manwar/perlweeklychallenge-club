#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

sub reverse_pairs{
  my $it = combinations($_[0],2);
  my $count = 0;
  while(my $c = $it->next){
    $count++ if $c->[0] > ($c->[1] * 2)
  }
  $count
}

printf "%d\n",reverse_pairs([1,3,2,3,1]);
printf "%d\n",reverse_pairs([2,4,3,5,1]);

