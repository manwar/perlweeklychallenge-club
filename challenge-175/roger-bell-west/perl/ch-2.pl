#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

use Math::Prime::Util qw(euler_phi);

is_deeply(perfecttotient(20),
          [ 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471,
            729, 2187, 2199, 3063, 4359, 4375, 5571 ],
          'example 1');

sub iteratedtotient($n0) {
  my $p = 0;
  my $n = $n0;
  while (1) {
    $n = euler_phi($n);
    $p += $n;
    if ($n == 1) {
      last;
    }
    if ($p > $n0) {
      last;
    }
  }
  return $p;
}

sub perfecttotient($ct) {
  my @o = ();
  my $n = 1;
  while (scalar @o < $ct) {
    $n++;
    if (iteratedtotient($n) == $n) {
      push @o,$n;
    }
  }
  return \@o;
}
