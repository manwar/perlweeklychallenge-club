#!/usr/bin/perl

# Perl Weekly Challenge - 115
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK2
#
# Task 2 - Largest Multiple
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(firstidx);

use Test::More;

# Prototype(s)
sub largestMultiple(\@);

my %tests = (
    6210 => [1, 0, 2, 6],
    8412 => [1, 4, 2, 8],
    7614 => [4, 1, 7, 6], 
      -1 => [1, 3, 5, 7], 
  872112 => [1, 1, 2, 2, 8, 7], 
);

foreach my $test (sort keys %tests) {
  is(largestMultiple(@{$tests{$test}}), $test);
}

done_testing;

sub largestMultiple(\@) {
  my ($ar) = @_;

  my @d = sort @$ar;

  # Smallest digit is odd?
  if ($d[0] % 2 == 1) {
    # find index of smallest even digit
    my $sEidx = firstidx { $_ % 2 == 0 } @d;
    # Can we swap?
    if ($sEidx >= 0) {
      ($d[0],$d[$sEidx]) = ($d[$sEidx], $d[0]);
    } else {
      # wrong input delivered
      return -1;
    }
  }

  return join('',reverse @d);
}

