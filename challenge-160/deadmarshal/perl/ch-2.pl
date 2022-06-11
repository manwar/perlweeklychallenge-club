#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub equilibrium_index{
  my ($arr) = @_;
  my ($left, $right) = (0, sum0 @$arr);
  my $ret;
  while(my ($i, $j) = each @$arr){
    $right -= $j;
    $ret = $i if $left == $right;
    $left += $j;
  }
  return $ret ? $ret : -1;
}

print equilibrium_index([1, 3, 5, 7, 9]), "\n";
print equilibrium_index([1, 2, 3, 4, 5]), "\n";
print equilibrium_index([2, 4, 2]), "\n";
