#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(divisor_sum);

sub abundant_odd_numbers{
  my @arr;
  my $i = 1;
  do{
    push @arr, $i if(divisor_sum($i) > (2*$i)) && ($i % 2 != 0);
    $i++;
  }until(@arr == 20);
  return @arr;
}

print "$_ " foreach abundant_odd_numbers;
