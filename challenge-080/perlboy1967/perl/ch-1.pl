#!/usr/bin/perl

# Perl Weekly Challenge - 080
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#
# Task 1 - Smallest Positive Number Bits
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::MoreUtils qw(uniq each_array);

@ARGV = qw(-2 0 1 2 3 6 -1 8)
  unless (scalar @ARGV);

my (@N) = @ARGV;

die "Please supply list of minimal two integer values (negative numbers and zero are allowed)"
  unless (scalar @N >= 2 and not grep( !m/^[-]*\d+$/, @N));

printf "Input: \@N = (%s)\n", join(', ', @N);
printf "Output: %s\n", findSmallestPositiveMissing(\@N);

sub findSmallestPositiveMissing {
  my ($ar) = @_;

  my @p1 = uniq sort { $a <=> $b } grep { $_ >= 0 } @$ar;
  my @p2 = @p1[1 .. scalar(@p1) - 1]; 

  my $ea = each_array(@p1, @p2);
  while (my ($p1, $p2) = $ea->()) {
    if (defined $p2 and $p1 < $p2 - 1) {
      return $p1 + 1;
    }
  }

  return 'Undef';
}
