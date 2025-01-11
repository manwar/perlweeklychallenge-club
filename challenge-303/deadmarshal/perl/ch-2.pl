#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub delete_and_earn{
  my $max = max @{$_[0]};
  my @total = (0) x ($max+1);
  map{$total[$_] += $_} @{$_[0]};
  my $first = $total[0];
  my $second = max($total[0],$total[1]);
  foreach my $i(2..$max){
    my $curr = max(($first+$total[$i]),$second);
    $first = $second;
    $second = $curr
  }
  $second
}

printf "%d\n",delete_and_earn([3,4,2]);
printf "%d\n",delete_and_earn([2,2,3,3,3,4]);

