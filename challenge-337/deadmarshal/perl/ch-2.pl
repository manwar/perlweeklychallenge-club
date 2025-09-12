#!/usr/bin/env perl
use strict;
use warnings;

sub odd_matrix{
  my ($row,$col,$m) = @_;
  my @g;
  push @g,[(0) x $col] foreach(0..$row-1);
  foreach my $p(@$m){
    foreach(0..$col-1) {
      ++$g[$p->[0]]->[$_]
    }
    foreach(0..$row-1){
      ++$g[$_]->[$p->[1]]
    }
  }
  my $res = 0;
  foreach my $i(0..$row-1){
    foreach my $j(0..$col-1) {
      $res++ if $g[$i][$j] % 2
    }
  }
  $res
}

printf "%d\n", odd_matrix(2,3,[[0,1],[1,1]]);
printf "%d\n", odd_matrix(2,2,[[1,1],[0,0]]);
printf "%d\n", odd_matrix(3,3,[[0,0],[1,2],[2,1]]);
printf "%d\n", odd_matrix(1,5,[[0,2],[0,4]]);
printf "%d\n", odd_matrix(4,2,[[1,0],[3,1],[2,0],[0,1]]);

