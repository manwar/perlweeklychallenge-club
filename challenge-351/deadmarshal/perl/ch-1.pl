#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub special_average{
  my ($arr) = @_;
  return 0 if @$arr < 2;
  @$arr = sort {$a <=> $b} @$arr;
  my @sub = splice @$arr,1,$#$arr-1;
  (sum0 @sub) / @sub
}

printf "%d\n",special_average([8000,5000,6000,2000,3000,7000]);
printf "%d\n",special_average([100_000,80_000,110_000,90_000]);
printf "%d\n",special_average([2500,2500,2500,2500]);
printf "%d\n",special_average([2000]);
printf "%d\n",special_average([1000,2000,3000,4000,5000,6000]);

