#!/usr/bin/perl

# Perl Weekly Challenge - 074
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
# Task 1 - Majority Element
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(max);
use POSIX q(floor);

my @A = @ARGV;

# Create a list with some random numbers if none provided
@A = map {int(rand(3))} (1 .. 3 + rand(5))
  if (!scalar @A);

my $N = scalar(@A);
my %ME = ();
my $reason;
my $me;

$ME{$_}++ foreach (@A);
my $max = max(values %ME);
my @max = grep { $_ if $ME{$_} == $max } keys %ME;

if (scalar @max ==  1 and
    $max > floor($N/2)) {
  ($me, $reason) = ($max[0],
                    sprintf('as %d appears %d times in list which is more than floor(%d/2).',
                             $max[0], $max, $N));
} else {
  ($me, $reason) = (-1,
                    sprintf('as none of the elements appears more than floor(%d/2).',
                            $N));
}

printf "Input: \@A = (%s)\n", join(', ', @A);
printf "Output: %d %s\n", $me, $reason;

