#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::Util qw[min];
use Data::Dumper::OneLine;

# Input
my @N = (
  [0, 0, 0, 1, 1, 1],
  [1, 1, 1, 1, 1, 1],
  [0, 0, 1, 0, 0, 1],
  [0, 0, 1, 1, 1, 1],
  [0, 0, 1, 1, 1, 1],
);

# Largest Rectangle
my @R = ();
my @points = ();
my $totalArea = 0;

for (my $x = 0; $x < scalar @N; $x++) {
  for (my $y = 0; $y < scalar @{$N[0]}; $y++) {
    if($N[$x][$y] == 1) {
      my $left = 1, my $up = 1;
      my $leftArea = 1, my $upArea = 1, my $maxArea = 1;
      my $leftPoint, my $upPoint, my $maxPoint;

      # Count left and up values
      $left = @{$R[$x][$y-1]}[0] + 1 if($y > 0);
      $up = @{$R[$x-1][$y]}[1] + 1 if($x > 0);

      # Get maximum area on the left side
      if($y > 0) {
        my $limitUp = $up;
        $leftArea = $up;
        $leftPoint = [$x - $limitUp + 1, $y];

        for(my $d = 1; $d < $left; $d++) {
          $limitUp = min($limitUp, @{$R[$x][$y-$d]}[1]);
          my $area = ($d + 1) * $limitUp;

          if($area > $leftArea) {
            $leftArea = $area;
            $leftPoint = [$x - $limitUp + 1, $y - $d];
          }
        }
      }

      # Get maximum area on the upper side
      if($x > 0) {
        my $limitLeft = $left;
        $upArea = $left;
        $upPoint = [$x, $y - $limitLeft + 1];

        for(my $d = 1; $d < $up; $d++) {
          $limitLeft = min($limitLeft, @{$R[$x-$d][$y]}[0]);
          my $area = ($d + 1) * $limitLeft;

          if($area > $upArea) {
            $upArea = $area;
            $upPoint = [$x - $d, $y - $limitLeft + 1];
          }
        }
      }

      # Get maximum area until now
      if($leftArea > $upArea) {
        $maxPoint = $leftPoint;
        $maxArea = $leftArea;
      } else {
        $maxPoint = $upPoint;
        $maxArea = $upArea;
      }

      if($maxArea > $totalArea) {
        @points = (@$maxPoint[0], @$maxPoint[1], $x, $y);
        $totalArea = $maxArea;
      }

      $R[$x][$y] = [$left, $up];
    } else {
      $R[$x][$y] = [0, 0];
    }
  }
}

# Output
if($totalArea <= 1) {
  say "No rectangule was found on the matrix.";
} else {
  say "Result rectangule is located between (".$points[0].", ".$points[1].") and (".$points[2].", ".$points[3].") ".
    "with total area of ".$totalArea.".";
}