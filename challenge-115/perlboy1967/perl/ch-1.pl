#!/usr/bin/perl

# Perl Weekly Challenge - 115
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/#TASK1
#
# Task 1 - String Chain
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Algorithm::Combinatorics qw(permutations);

use Test::More;

is(isStringChain(qw(abc dea cd )), 1);
is(isStringChain(qw(ade cbd fgh)), 0);
is(isStringChain(qw(ab bc ca bb)), 1);
is(isStringChain(qw(ab cd da bd)), 0);
is(isStringChain(qw(abba adda acca axxa)), 1);
is(isStringChain(qw(the weekly challenge)), 0);

done_testing;

sub isStringChain {
  my (@l) = @_;

  # We only need the first and last char
  map { s/^(.).*?(.)$/$1$2/ } @l;

  # Build regexp
  my $re = qr '^(.)'.join('',map {"(.)\\$_"} (2 .. scalar @l)).'\\1$';

  my $iter = permutations(\@l);
  while (my $ar = $iter->next()) {
    if (join('',@$ar) =~ m#$re#) {
      return 1;
    }
  }

  return 0;
}

