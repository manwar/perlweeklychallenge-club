#!/usr/bin/env perl
use strict;
use warnings;

sub is_alphabetical_order{
  my @arr = split '',$_[0];
  map{return 0 if $arr[$_] lt $arr[$_-1]} 1..$#arr;
  1
};

sub odd_one_out{
  my $count = 0;
  map{$count++ unless is_alphabetical_order $_} @{$_[0]};
  $count
}

printf "%d\n", odd_one_out(['abc', 'xyz', 'tsu']);
printf "%d\n", odd_one_out(['rat', 'cab', 'dad']);
printf "%d\n", odd_one_out(['x','y','z']);

