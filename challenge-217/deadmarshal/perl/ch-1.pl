#!/usr/bin/env perl
use strict;
use warnings;

sub sorted_matrix{
  (sort {$a <=> $b} map{@$_} @{$_[0]})[2];
}

printf "%d\n", sorted_matrix([[3,1,2],[5,2,4],[0,1,3]]);
printf "%d\n", sorted_matrix([[2,1],[4,5]]);
printf "%d\n", sorted_matrix([[1,0,3],[0,0,0],[1,2,1]]);

