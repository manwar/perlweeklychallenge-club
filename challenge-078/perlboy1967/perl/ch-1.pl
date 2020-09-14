#!/usr/bin/perl

# Perl Weekly Challenge - 078
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#
# Task 1 - Leader Element
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(max);

my @A = (9, 10, 7, 5, 6, 1);

sub findLeaderElement {
  my ($arL) = @_;

  my $maxIdx = scalar(@$arL) - 1;

  my %maxLoc;
  my @max = map {
    my $max = max(@$arL[$_ .. $maxIdx]);
    push(@{$maxLoc{$max}}, $_);
    $max;
  } reverse (0 .. $maxIdx);

  return @$arL[$maxLoc{max(keys %maxLoc)}[0] .. $maxIdx];
}  

printf "Input: (%s)\n", join(', ', @A);
printf "Output: (%s)\n", join(', ', findLeaderElement(\@A));
