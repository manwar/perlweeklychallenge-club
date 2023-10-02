#!/bin/perl

=pod

The Weekly Challenge - 217
- https://theweeklychallenge.org/blog/perl-weekly-challenge-217

Author: Niels 'PerlBoy' van Dijke

Task 2: Matrix Score
Submitted by: Mohammad S Anwar

You are given a m x n binary matrix i.e. having only 1 and 0.

You are allowed to make as many moves as you want to get the highest score.

|| A move can be either toggling each value in a row or column.

To get the score, convert the each row binary to dec and return the sum.

=cut

use v5.16;

use common::sense;

use List::Util qw(sum);

use Test::More;

sub matrixScore (\@) {
  my ($ar) = @_;
  my $nR = @$ar - 1;
  my $nC = @{$ar->[0]} - 1;

  # First make sure each row has its MSB set
  for (@$ar) {
    map { $_ = ++$_ % 2 } @$_ if ($$_[0] == 0);
  }

  for my $c (1 .. $nC) {
    my $ones = grep { $ar->[$_][$c] == 1 } (0 .. $nR);

    # Flip bits in column C if number of '1's is smaller than # of rows
    map { $ar->[$_][$c] = ++$$ar[$_][$c] % 2 } (0 .. $nR) 
      if ($ones < $nR);
  }

  return sum(map{oct('0b'.join('',@$_))} @$ar);
}


is(matrixScore(@{[[0,0,1,1],
                  [1,0,1,0],
                  [1,1,0,0],
                 ]}),39);

done_testing;
