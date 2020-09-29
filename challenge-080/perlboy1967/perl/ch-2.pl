#!/usr/bin/perl

# Perl Weekly Challenge - 080
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#
# Task 2 - Count Candies
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(sum);

@ARGV = qw(1 4 3 2)
  unless (scalar @ARGV);

my (@N) = @ARGV;

die "Please supply list of minimal two positive integer values"
  unless (scalar @N >= 2 and not grep( !m/^[-]*\d+$/, @N));

printf "Input: \@N = (%s)\n", join(', ', @N);
printf "Output: %s\n", countCandies(@N);

sub countCandies {
  my (@r) = @_;

  # Give each candidate one initial candy
  my @c = map { 1 } @r;

  # Give additional candy based on ranking v.s. neighbours
  foreach my $i (0 .. scalar(@r) - 1) {
    $c[$i]++ if (defined $r[$i + 1] and 
                 $r[$i] > $r[$i + 1]);
    $c[$i]++ if ($i > 0 and 
                 $r[$i] > $r[$i - 1]);
  }

  return sum(@c);
}
