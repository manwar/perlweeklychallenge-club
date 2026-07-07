#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub smaller_greater_element{
  my ($arr) = @_;
  my ($min,$max) = ($arr->[0],$arr->[0]);
  ($_ < $min) ? ($min = $_)
    : ($max < $_) && ($max = $_) foreach @$arr;
  @$arr - grep {$min == $_ || $max == $_} @$arr
}

is smaller_greater_element([2,4]),0,'Example 1';
is smaller_greater_element([1,1,1,1]),0,'Example 2';
is smaller_greater_element([1,1,4,8,12,12]),2,'Example 3';
is smaller_greater_element([3,6,6,9]),2,'Example 4';
is smaller_greater_element([0,-5,10,-2,4]),3,'Example 5';

done_testing();

