#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq);

sub two_out_of_three
{
  my %hash;
  map{$hash{$_}++ foreach uniq @$_} @{$_[0]};
  sort{$a <=> $b} grep{$hash{$_} >= 2} keys %hash
}

printf "(%s)\n", join ',' => two_out_of_three([[1,1,2,4],[2,4],[4]]);
printf "(%s)\n", join ',' => two_out_of_three([[4,1],[2,4],[1,2]]);

