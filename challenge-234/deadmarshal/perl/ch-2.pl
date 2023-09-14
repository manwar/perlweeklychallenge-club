#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0 product);
use Algorithm::Combinatorics qw(combinations);

sub unequal_triplets{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  my @keys = keys %h;
  @keys < 3 ? 0 : sum0 map{product @h{@$_}} combinations(\@keys,3);
}

printf "%d\n", unequal_triplets([4,4,2,4,3]);
printf "%d\n", unequal_triplets([1,1,1,1,1]);
printf "%d\n", unequal_triplets([4,7,1,10,7,4,1,1]);

