#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub array_median{
  my ($arr1,$arr2) = @_;
  my @merged = sort {$a <=> $b} (@$arr1,@$arr2);
  return 0.0 if @merged == 0;

  if(@merged % 2 == 1) {
    return $merged[int(@merged / 2)] + 0.0
  } else {
    my $left_middle = @merged / 2 - 1;
    return ($merged[$left_middle] + $merged[$left_middle+1]) / 2
  }
}

is array_median([2],[4]),3.0,'Example 1';
is array_median([1..3],[7..10]),7.0,'Example 2';
is array_median([],[10,20,30,40]),25.0,'Example 3';
is array_median([100],[1..7]),4.5,'Example 4';
is array_median([1,2,2],[2,2,3]),2.0,'Example 5';

done_testing();

