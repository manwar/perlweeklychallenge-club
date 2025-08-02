#!/usr/bin/env perl
use strict;
use warnings;

sub count_equal_divisible{
  my ($arr,$k) = @_;
  my $count = 0;
  foreach my $i(0..@$arr-2){
    foreach my $j($i+1..@$arr-1){
      ++$count if $arr->[$i] == $arr->[$j] && ($i*$j) % $k == 0
    }
  }
  $count
}

printf "%d\n",count_equal_divisible([3,1,2,2,2,1,3],2);
printf "%d\n",count_equal_divisible([1,2,3],1);

