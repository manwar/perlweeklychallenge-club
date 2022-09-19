#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

use Math::Complex;

use Test::More tests => 3;

my $EPSILON = 1e-7;

my @p = (676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716e-6,
        1.5056327351493116e-7);

cmp_ok(abs(gamma(3)-2), '<=', $EPSILON,'example 1');
cmp_ok(abs(gamma(5)-24), '<=', $EPSILON,'example 2');
cmp_ok(abs(gamma(7)-720), '<=', $EPSILON,'example 3');

sub drop_imag($z0) {
  my $z = $z0;
  if (abs(Im($z0)) <= $EPSILON) {
    $z = Math::Complex->make(Re($z),0);
  }
  return $z;
}

sub gamma($z0) {
  my $z = Math::Complex->make($z0,0);
  my $y;
  if (Re($z) < 0.5) {
    $y = pi / (sin(pi * $z) * gamma(1-$z));
  } else {
    $z--;
    my $x = 0.99999999999980993;
    foreach my $i (0..$#p) {
      $x += $p[$i] / ($z + $i + 1);
    }
    my $t = $z + scalar(@p) - 0.5;
    $y = sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $x;
  }
  return drop_imag($y);
}
