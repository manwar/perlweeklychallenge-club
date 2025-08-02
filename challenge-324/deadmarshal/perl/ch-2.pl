#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(subsets);
use List::Util qw(reduce);

sub total_xor{
  my $it = subsets($_[0]);
  my $sum = 0;
  while(my $s = $it->next){
    $sum += reduce {$a ^ $b} 0, @$s
  }
  $sum
}

printf "%d\n",total_xor([1,3]);
printf "%d\n",total_xor([5,1,6]);
printf "%d\n",total_xor([3,4,5,6,7,8]);

