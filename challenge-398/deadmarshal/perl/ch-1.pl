#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);
use Test::More tests => 5;

sub divisible_average{
  my @arr = grep {$_ % 2 == 0 && $_ % 3 == 0} @{$_[0]};
  return 0 unless @arr;
  int((sum0 @arr) / @arr)
}

is divisible_average([18,5,7,11]),18,'Example 1';
is divisible_average([6,12,18,24,30,40]),18,'Example 2';
is divisible_average([3,9,15,21,27]),0,'Example 3';
is divisible_average([6,12,14,20]),9,'Example 4';
is divisible_average([6,6,6,12,12]),8,'Example 5';

