#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);

sub beautiful_arrangement{
  my $it = permutations([1..$_[0]]);
  my $c = 0;
 perm:
  while(my $p = $it->next){
    foreach my $i(1..$_[0]){
      next perm if $p->[$i-1] % $i && $i % $p->[$i-1]
    }
    $c++
  }
  $c
}

printf "%d\n",beautiful_arrangement(2);
printf "%d\n",beautiful_arrangement(1);
printf "%d\n",beautiful_arrangement(10);

