#!/usr/bin/perl

# Perl Weekly Challenge - 107
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/#TASK1
#
# Task 1 - Self-descriptive Numbers
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(min);

# Prototypes
sub incBaseNnumber ($\@);
sub isSelfDescriptiveBaseNnumber ($\@);

my ($found, $base) = (0, 1);

while ($found < 3) {
  my @d = (map { 0 } (1 .. $base - 1), 1);
  do {
    if (isSelfDescriptiveBaseNnumber($base,@d)) {
      printf "Match: %s\n", join('',@d);
      $found++;
    }
  } while (!incBaseNnumber($base,@d));
  $base++;
} 


# This subroutine will only work up to base 26
sub incBaseNnumber ($\@) {
  my ($b,$arDigits) = @_;

  my ($overflow,$d,$dMax) = (0,0,scalar(@$arDigits));

  while (!$overflow) {
    $arDigits->[$d] = ($arDigits->[$d] + 1) % $b;
    last if $arDigits->[$d++];
    if ($d >= $dMax) {
      push(@$arDigits,1);
      $overflow++; 
    }
  }

  return $overflow; 
}


# This subroutine will only work up to base 10
sub isSelfDescriptiveBaseNnumber ($\@) {
  my ($b,$arDigits) = @_;

  my @checkDigit;
  for my $d (0 .. $b - 1) {
    $checkDigit[$d] = scalar(grep { $_ == $d } @$arDigits) == $arDigits->[$d];
  }

  return min(@checkDigit) == 1;
}
