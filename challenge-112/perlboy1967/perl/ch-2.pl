#!/usr/bin/perl

# Perl Weekly Challenge - 112
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/#TASK2
#
# Task 2 - Climb Stairs
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;
use Test::Deep;

use Data::Printer;

# Prototype(s)
sub climbStairs($\@);

my @stepOptions = (1,2);

cmp_deeply (climbStairs(3,@stepOptions), 
            [[1,1,1],[1,2],[2,1]]);
cmp_deeply (climbStairs(4,@stepOptions), 
            [[1,1,1,1],[1,1,2],[1,2,1],[2,1,1],[2,2]]);

@stepOptions = (1,2,3);
cmp_deeply (climbStairs(4,@stepOptions),
            [[1,1,1,1],[1,1,2],[1,2,1],[1,3],[2,1,1],[2,2],[3,1]]);

done_testing;

sub climbStairs($\@) {
  my ($height,$arStepOptions) = @_;
  my ($solutions,$steps) = ([],[]);

  _climb($height,$arStepOptions,$steps,$solutions);
  
  return $solutions;
}

sub _climb {
  my ($height,$arStepOptions,$arSteps,$arSolutions) = @_;

  my @steps = @$arSteps;

  foreach my $step (@$arStepOptions) {
    if ($height-$step >= 0) {
      push(@steps,$step);
      _climb($height-$step,$arStepOptions,\@steps,$arSolutions);
      push(@$arSolutions,[@steps]) 
        if ($height-$step == 0);
      pop(@steps);
    }
  }
}
