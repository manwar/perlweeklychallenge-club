#!/bin/perl

=pod

The Weekly Challenge - 192
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-192/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Equal Distribution
Submitted by: Mohammad S Anwar

You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same. 
If you succeed then print the total moves otherwise print -1.

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

1) You can only move a value of '1' per move
2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

=cut

use v5.16;
use warnings;

use Test::More;

use List::Util qw(sum);
use List::MoreUtils qw(firstidx minmax);

my @t = (
  [[1,0,5], 4],
  [[0,2,0],-1],
  [[0,3,0], 2],
  [[0,0,0], 0],
  [[0,8,1,1,6,2], 8],
  [[1,2,3,4,5,6,7,8,9], 60],
  [[1,3,2,5,4,7,6,9,8], 56],
);


sub equalDistribution {
  printf "Input: [%s]\n", join(',',@_);

  my $sum = sum(@_);
  my $n = scalar(@_);

  return -1 if ($sum % $n != 0);

  my $m = 0;
  while (1) {
    my ($min,$max) = minmax(@_);
    last if ($min == $max);

    $m++;

    my $i = firstidx { $_ == $max } @_;

    # Which side needs the +1 the most?
    my @l = @_[0 .. $i-1];
    my @r = @_[$i+1 .. $n-1];

    if ((scalar(@l) ? sum(@l)/scalar(@l) : $min-1) < 
        (scalar(@r) ? sum(@r)/scalar(@r) : $max+1)) {
      $_[$i-1]++;
    } else {
      $_[$i+1]++;
    }

    $_[$i]--; 

    printf "Move %d: [%s]\n", $m, join(',',@_);
  }

  return $m;
}


for (@t) {
  is(equalDistribution(@{$$_[0]}),$$_[1]);
}

done_testing;
