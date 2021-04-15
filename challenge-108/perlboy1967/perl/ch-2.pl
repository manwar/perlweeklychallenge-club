#!/usr/bin/perl

# Perl Weekly Challenge - 108
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-108/#TASK2
#
# Task 2 - Bell Numbers
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

my @bn = (1);

# Using the 'Bell triangle' algorithm

my $bnT = [[1]];

foreach my $bTRidx (1..8) {
  my $prevTRdim = scalar(@{$bnT->[$bTRidx-1]});

  # Copy
  $bnT->[$bTRidx][0] = $bnT->[$bTRidx-1][$prevTRdim-1];
  foreach my $bTCidx (1 .. $prevTRdim) {

    # Add
    $bnT->[$bTRidx][$bTCidx] =  
      $bnT->[$bTRidx-1][$bTCidx-1] +  
      $bnT->[$bTRidx][$bTCidx-1];
  }

  push(@bn, $bnT->[-1][-1]);
} 

# Print
printf "%s\n", join(' ',1,@bn);
