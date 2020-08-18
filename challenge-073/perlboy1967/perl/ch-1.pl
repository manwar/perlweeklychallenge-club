#!/usr/bin/perl

# Perl Weekly Challenge - 073
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/
#
# Task 1 - Min Sliding Window
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(min);

my ($S) = @ARGV;

die "S must be a positive integer"
 unless (defined $S and $S =~ m#^[1-9][0-9]*$#);

my @S;

# Create list with random integer values
my @A = map {int(rand(100))} (1 .. $S * 3);

printf "Input:\n\t\@A = (%s)\n\t\$S = %d\n\n", join(', ', @A), $S;

for (my $i = 0; $i < scalar(@A) - $S + 1; $i++) {
  my @s = @A[$i .. $i + $S - 1];

  push(@S, min(@s));

  printf "min(%s) = %d\n", join(', ',@s), $S[-1];
}

printf "\nOutput:\n\t\@S = (%s)\n", join(', ', @S);
