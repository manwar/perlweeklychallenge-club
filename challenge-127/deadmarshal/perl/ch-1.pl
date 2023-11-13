#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub disjoint_sets{
  my ($s1,$s2) = @_;
  my %h;
  map{$h{$s1->[$_]}++; $h{$s2->[$_]}++} 0..$#$s1;
  all{$_ == 1} values %h;
}

printf "%d\n", disjoint_sets([1,2,5,3,4],[4,6,7,8,9]);
printf "%d\n", disjoint_sets([1,3,5,7,9],[0,2,4,6,8]);

