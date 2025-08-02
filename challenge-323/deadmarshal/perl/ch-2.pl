#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);

sub tax_amount{
  my ($res,$prev) = (0,0);
  foreach(@{$_[1]}){
    $res += max(0,min($_[0],$_->[0]) - $prev) * $_->[1];
    $prev = $_->[0]
  }
  $res / 100.0
}

printf "%.2f\n",tax_amount(10,[[3,50],[7,10],[12,25]]);
printf "%.2f\n",tax_amount(2,[[1,0],[4,25],[5,50]]);
printf "%.2f\n",tax_amount(0,[[2,50]]);

