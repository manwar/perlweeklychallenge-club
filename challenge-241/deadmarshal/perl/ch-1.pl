#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

sub arithmetic_triplets{
  my $count = 0;
  my $iter = combinations($_[0],3);
  while(my $c = $iter->next){
    $count++ if($c->[1] - $c->[0]) == $_[1] == ($c->[2] - $c->[1]);
  }
  $count
}

printf "%d\n", arithmetic_triplets([0,1,4,6,7,10],3);
printf "%d\n", arithmetic_triplets([4,5,6,7,8,9],2);

