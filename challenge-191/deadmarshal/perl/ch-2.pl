#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);

sub is_cute{
  map{return 0 if $_ % $_[0]->[$_-1] && $_[0]->[$_-1] % $_}
    (1..@{$_[0]});
  1;
}

sub cute_list{
  my @arr = 1..$_[0];
  my (@permutations,$count) = (permutations \@arr,0);
  foreach my $perm(@permutations){
    $count++ if is_cute($perm);
  }
  $count;
}

print cute_list(2), "\n";

