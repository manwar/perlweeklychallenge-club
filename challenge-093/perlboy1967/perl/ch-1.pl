#!/usr/bin/perl

# Perl Weekly Challenge - 093
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#
# Task 1 - Max Points
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(max);
use Algorithm::Combinatorics qw(combinations);
use Data::Printer;

# Unbuffered STDOUT
$|++;

while (<DATA>) {
  chomp();
  my @points = split(/;/);
  my @pXY = map{[split(/,/)]} @points;

  my %fP;
  my %fPc;
  my $formula;
  
  # Calculate 'a' and 'b' factors of line formula: 'y = ax + b'
  # from two points
  my $iter = combinations(\@pXY, 2);
  while (my $ar = $iter->next) {

    my $f;
    my ($a, $b) = ('');

    # Special case #1: X1 = X2 (vertical line)
    if ($ar->[0][0] == $ar->[1][0]) {

      $f = "x=$ar->[0][0]";

    } else {

      # Special case #2: Y1 = Y2 (horizontal line) 
      if ($ar->[0][0] == $ar->[1][0]) {
        $b = $ar->[0][1];
      } else {
        # a = dY / dX
        $a = ($ar->[0][1] - $ar->[1][1]) / 
             ($ar->[0][0] - $ar->[1][0]);
        # b = y - a.x
        $b = $ar->[0][1] - $a * $ar->[0][0];
      }

      $f = sprintf("y=%s*x+%s", $a, $b);
    }

    # Record the points against the line formula
    for my $i (0,1) {
      $fP{$f}{"($ar->[$i][0],$ar->[$i][1])"}++;
    }
      
    $fPc{$f} = scalar keys %{$fP{$f}};
  }

  my $max = max(values(%fPc));
  my @formulas = grep { $fPc{$_} == $max } keys %fPc;

  printf "-------------------------------------------------------\n";
  printf "Input: %s\n", '('.join('),(', @points).')';
  printf "Max points on same line: %d\n", $max;
  if ($max == 2) {
    printf "Suppressing %d matching results\n", scalar @formulas; 
  } else {
    my $i = 1;
    foreach $formula (sort @formulas) {
      printf "%d)\tPoints on '%s':\n", $i++, $formula;
      printf "\t%s\n", join(',', sort keys %{$fP{$formula}});
    }
  }
  printf "-------------------------------------------------------\n";
}

__DATA__
1,1;2,2;3,3
1,1;2,2;3,1;1,3;5,3
1,1;2,2;3,3;4,4;1,2;2,4;3,6;4,8;5,1;5,2;5,3;5,4
1,1;2,2;3,6;4,8
