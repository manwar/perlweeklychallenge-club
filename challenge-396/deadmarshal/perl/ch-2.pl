#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub trionic_array{
  my ($arr) = @_;
  my ($p,$n) = (0,scalar @$arr);
  $p++ while($p < $n - 2 && $arr->[$p] < $arr->[$p+1]);
  return '' if $p == 0;
  my $q = $p;
  $q++ while($q < $n-1 && $arr->[$q] > $arr->[$q+1]);
  return '' if $q == $p || $q == $n-1;
  $q++ while($q < $n-1 && $arr->[$q] < $arr->[$q+1]);
  $q == $n-1
}

is trionic_array([1,3,5,4,2,6,8]),1,'Example 1';
is trionic_array([1,4,4,2,1,3,5]),'','Example 2';
is trionic_array([2,10,3,1,9]),1,'Example 3';
is trionic_array([1,2,3,4,3,2,1]),'','Example 4';
is trionic_array([1,3,6,4,2,7,8,4]),'','Example 5';

