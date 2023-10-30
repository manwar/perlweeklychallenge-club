#!/usr/bin/env perl
use strict;
use warnings;

sub frequency_sort{
  my ($arr) = @_;
  my %h;
  $h{$_}++ foreach @$arr;
  sort{$h{$a} <=> $h{$b} || $b <=> $a} @$arr;
}

printf "(%s)\n", join ',', frequency_sort([1,1,2,2,2,3]);
printf "(%s)\n", join ',', frequency_sort([2,3,1,3,2]);
printf "(%s)\n", join ',', frequency_sort([-1,1,-6,4,5,-6,1,4,1]);

