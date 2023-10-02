#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub left_right_sum_diff
{
  my ($arr) = @_;
  my ($left,$right) = (0,sum0 $arr->@[1..$#$arr]);
  my @diffs;
  foreach(0..$#$arr){
    push @diffs, abs $left - $right;
    $left += $arr->[$_];
    $right -= $_ < $#$arr ? $arr->[$_+1] : 0;
  }
  @diffs
}

printf "(%s)\n", join ', ', left_right_sum_diff([10,4,8,3]);
printf "(%s)\n", join ', ', left_right_sum_diff([1]);
printf "(%s)\n", join ', ', left_right_sum_diff([1,2,3,4,5]);

