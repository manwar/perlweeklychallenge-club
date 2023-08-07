#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub unique_sum{
  my %hash;
  $hash{$_}++ foreach(@{$_[0]});
  sum0 grep{$hash{$_} == 1} keys %hash;
}

printf "%d\n", unique_sum([2,1,3,2]);
printf "%d\n", unique_sum([1,1,1,1]);
printf "%d\n", unique_sum([2,1,3,4]);

