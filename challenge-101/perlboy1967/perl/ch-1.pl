#!/usr/bin/perl

# Perl Weekly Challenge - 101
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/
#
# Task 1 - Pack a Spiral
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Data::Printer;
use Math::Prime::XS qw(primes);
use List::Util qw(min);

sub getMinGridDimensions(\@);
sub spiralArrayToGrid(\@$$);
sub printGrid($$$$);

my @A = (1..shift // 40);

my ($w, $h) = getMinGridDimensions(@A);
my $G = spiralArrayToGrid(@A, $w, $h);
printGrid($G, $w, $h, length($A[-1]));


sub getMinGridDimensions(\@) {
  my ($arA) = @_;

  my $A = scalar(@$arA);

  my $d = int(sqrt($A));
  do {
    my $q = int($A/$d);
    return sort { $a <=> $b } ($q,$d)
      if ($q * $d == $A);
    $d++;
  } while ($d <= int($A/2));
 
  return ($A,1);
}


sub spiralArrayToGrid(\@$$) {
  my ($arA, $w, $h) = @_;

  my $g;

  my ($r, $c) = (0,0);

  my @d = ([0,1],[1,0],[0,-1],[-1,0]);
  my $d = 0;

  foreach my $v (@$arA) {
    $g->[$r][$c] = $v;
    if ($r + $d[$d][0] == $w or
        $c + $d[$d][1] == $h or
        $r + $d[$d][0] < 0 or
        $c + $d[$d][1] < 0 or
        defined $g->[$r + $d[$d][0]][$c + $d[$d][1]]) {
      $d = (++$d % 4);
    }
    ($r, $c) = ($r + $d[$d][0], $c + $d[$d][1]); 
  }

  return $g;
}

sub printGrid($$$$) {
  my ($g, $w, $h, $width) = @_;

  for (my $r = 0; $r < $w; $r++) {
    printf "%${width}d " x $h."\n", @{$g->[$r]};
  }
}
