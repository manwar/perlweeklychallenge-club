#!/usr/bin/perl

# Perl Weekly Challenge - 098
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/
#
# Task 2 - Search Insert Position
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(firstidx);

# Unbuffered STDOUT
$|++;

while (<DATA>) {
  chomp;

  my ($N, @N) = split(/,/);
  @N = sort(@N);

  my $idx = firstidx { $_ >= $N } @N;
  $idx = scalar(@N)
    if ($idx < 0);

  printf "Input: \@N = (%s) and \$N = %d\n", join(',', @N), $N;
  printf "Output: %d\n\n", $idx;
} 
 
__DATA__
3,1,3,2,4
6,1,7,5,3
10,14,12,16,18
19,15,13,11,17
