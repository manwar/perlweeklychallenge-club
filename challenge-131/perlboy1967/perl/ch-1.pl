#!/usr/bin/perl

# Perl Weekly Challenge - 131
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-131/#TASK1
#
# Task 1 - Consecutive Arrays
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(slide);

use Test::More;
use Test::Deep;


cmp_deeply(consecutiveArrays(1,2,3,6,7,8,9), [[1,2,3],[6,7,8,9]]);
cmp_deeply(consecutiveArrays(11,12,14,17,18,19), [[11,12],[14],[17,18,19]]);
cmp_deeply(consecutiveArrays(2,4,6,8), [[2],[4],[6],[8]]);
cmp_deeply(consecutiveArrays(1,2,3,4,5), [[1,2,3,4,5]]);

done_testing;


sub consecutiveArrays {

  my @r = ([]);

  slide { 
    push(@{$r[-1]}, $a);
    if ($a != $b - 1) { 
      push(@r, []);
    } 
  } @_;

  push(@{$r[-1]}, $_[-1]);

  return [@r];
}

