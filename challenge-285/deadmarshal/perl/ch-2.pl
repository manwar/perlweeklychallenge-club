#!/usr/bin/env perl
use strict;
use warnings;

sub making_change{
  my ($amount) = @_;
  my @coins = (1,5,10,25,50);
  my @dp = (0) x ($amount+1);
  $dp[0] = 1;
  foreach my $c(@coins){
    foreach my $i($c..$amount) {
      $dp[$i] += $dp[$i-$c]
    }
  }
  $dp[$amount]
}

printf "%d\n",making_change(9);
printf "%d\n",making_change(15);
printf "%d\n",making_change(100);

