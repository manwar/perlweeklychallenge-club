#!/usr/bin/perl

# Perl Weekly Challenge - 084
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#
# Task 2 - Find Square
#
# Author: Niels 'PerlBoy' van Dijke

use 5.16.3; # Matching the CentOS 7 distro I'm using

use strict;
use warnings;

use List::Util qw(min first sum);
use Data::Printer;

sub checkMatrix($);
sub findNumberOfSquares($);
sub printMatrix($);

my $M = [
  [qw(1 1 0 1)],
  [qw(1 1 0 0)],
  [qw(0 1 1 1)],
  [qw(1 0 1 1)],
];

printf "Input:\n%s\n", printMatrix($M);
printf "\n";
printf "Output: %d\n", findNumberOfSquares($M);

sub checkMatrix($) {
  my ($ar) = @_;

  my ($dx, $dy) = (scalar @{$ar->[0]}, scalar @$ar);

  foreach my $row (@$ar) {
    die "Matrix size issue"
      unless (scalar @$row == $dx);
    die "Only '0' or '1' allowed"
      unless (scalar(grep { /^[01]$/ } @$row) == $dx);
  }

  return ($dx, $dy);
} 


sub findNumberOfSquares($) {
  my ($ar) = @_;

  my ($dX, $dY) = checkMatrix($M);

  my $nOs = 0;

  for my $dim (2 .. min($dX, $dY)) {
    for my $row (0 .. $dY - $dim) {
      for my $col (0 .. $dX - $dim) {
        my @cells = (
          $ar->[$row][$col],                       #TL
          $ar->[$row + $dim - 1][$col],            #TR
          $ar->[$row][$col + $dim - 1],            #BL
          $ar->[$row + $dim - 1][$col + $dim - 1], #BR
        );
        $nOs++ if (sum(@cells) == 4);
      }
    }
  }

  return $nOs;
}


sub printMatrix($) {
  my ($ar) = @_;

  return join("\n", map { '[ '.join(' ', @{$_}).' ]' } @$ar);
}
