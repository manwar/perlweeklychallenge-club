#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(rbt([1,2,3,4,-1,5,6,-1,7]),[27,26,25,24,-1,23,22,-1,21],'example 1');

sub rbt(@ti) {
  my $s=0;
  for @ti -> $n {
    if ($n>=0) {
      $s+=$n;
    }
  }
  my @to;
  for @ti -> $n {
    if ($n>=0) {
      push @to,$s-$n;
    } else {
      push @to,$n;
    }
  }
  return @to;
}