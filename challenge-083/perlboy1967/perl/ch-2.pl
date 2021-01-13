#!/usr/bin/perl

# Perl Weekly Challenge - 083
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-083/
#
# Task 2 - Flip Array
#
# Author: Niels 'PerlBoy' van Dijke

use 5.16.3; # CentOS 7 distro

use strict;
use warnings;

use List::Util qw(sum);
use Scalar::Util qw(looks_like_number);

@ARGV = (1 .. 10)
  unless @ARGV;

my (@A) = @ARGV;

die "Only numerical values please"
  if (grep { !looks_like_number($_) } @A);

printf "Input: \@A = (%s)\n", join(', ', @A);

my $min = sum(@A);
my $bits = scalar(@A);
foreach my $i (0 .. 2**$bits - 1) {
  my @multiplyFactor = map { $_ ? -1 : 1 } split(//,sprintf("%0${bits}b", $i));
  my @flip = map { $_ * shift(@multiplyFactor) } @A;
  my $sum = sum(@flip);

  if ($sum >= 0 and $sum < $min) {
    $min = $sum;
    @A = @flip;
  }

  last if ($min == 0);
} 

printf "Output: %d\n", $min;
printf "Evidence: %s\n", join(' + ', map { "($_)" } @A);
