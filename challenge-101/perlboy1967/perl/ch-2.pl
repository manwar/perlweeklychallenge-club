#!/usr/bin/perl

# Perl Weekly Challenge - 101
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/
#
# Task 2 - Origin-containing Triangle
#
# Author: Niels 'PerlBoy' van Dijke
#
# Algorithm used: sum of all angles in a 'circle' makes 360 degrees

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);
use Math::Trig qw(rad2deg acos_real);

sub calcZAngle($$$$);
sub originInsideTriangle (@);

my %triangles = (
  'Example 0' => [3,4,4,-3,-4,-3],
  'Example 1' => [0,1,1,0,2,2],
  'Example 2' => [1,1,-1,1,0,-3],
  'Example 3' => [0,1,2,0,-6,0],
  'Example 4' => [-1,0,0,0,0,1],
);

foreach my $c (sort keys %triangles) {
  my @v = @{$triangles{$c}};

  printf "Case: %s\n", $c;
  printf "Input: A=(%s,%s), B=(%s,%s), C=(%s,%s)\n", @v;
  printf "Output: %d\n", originInsideTriangle(@v);
  printf "\n";
}

sub calcZAngle($$$$) {
  my ($x1,$y1,$x2,$y2) = @_;

  # Cosine rule:
  #   c^2 = a^2 + b^2 - 2ab cos(gamma)
  #   gamma = acos((a^2 + b^2 - c^2) / 2ab)
  my $a = sqrt($x1**2 + $y1**2);
  my $b = sqrt($x2**2 + $y2**2);
  my $c = sqrt(($x2-$x1)**2 + ($y2-$y1)**2);

  return rad2deg acos_real(($a**2 + $b**2 - $c**2)/ (2.0 * $a * $b));
}

sub originInsideTriangle (@) {
  my ($x1,$y1,$x2,$y2,$x3,$y3) = @_;

  return 1 if ($x1 == 0 and $y1 == 0);
  return 1 if ($x2 == 0 and $y2 == 0);
  return 1 if ($x3 == 0 and $y3 == 0);

  # calculate angles:
  # AzB, BzC and AzC
  my %angle; 

  $angle{AzB} = calcZAngle($x1,$y1,$x2,$y2);
  $angle{BzC} = calcZAngle($x2,$y2,$x3,$y3);
  $angle{AzC} = calcZAngle($x1,$y1,$x3,$y3);

  my $angleTot = sum(values %angle);

  # Always tricky to exact compare floats...
  return (sprintf('%f',$angleTot) eq sprintf('%f',360) ? 1 : 0); 
}

