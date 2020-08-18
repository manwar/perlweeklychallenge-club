#!/usr/bin/perl

# Perl Weekly Challenge - 073
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/
#
# Task 2 - Smallest Neighbour
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(min);

my @N = (0);

# Create list with random integer values
my @A = map {int(rand(100))} (1 .. 10);

printf "Input:\n\t\@A = (%s)\n\n", join(', ', @A);

for (my $i = 1; $i < scalar(@A); $i++) {
  my @s = @A[0 .. $i-1];
  my $min = min(@s);

  push(@N, $min < $A[$i] ? $min : 0);

  printf "%d\tmin(%s) = %d, %d < %d ? %d : 0 => %d\n", 
    $A[$i], join(', ',@s), $min, $A[$i], $min, $min, $N[-1];
}

printf "\nOutput:\n\t\@S = (%s)\n", join(', ', @N);
