#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(additivenumber('112358'), 1, 'example 1');
is(additivenumber('12345'), 0, 'example 2');
is(additivenumber('199100199'), 1, 'example 3');

sub exdigits($digits, $start, $end) {
  my $x = 0;
  foreach my $i ($start .. $end) {
    $x *= 10;
    $x += $digits->[$i];
  }
  return $x;
}

sub additivenumber($digitstring) {
  my @digits = split '',$digitstring;
  my @stack;
  foreach my $i (0 .. $#digits - 3) {
    foreach my $j ($i + 1 .. $#digits - 2) {
      push @stack,[0, $i, $j];
    }
  }
  while (scalar @stack > 0) {
    my ($start_a, $end_a, $end_b) = @{pop @stack};
    my $start_b = $end_a + 1;
    my $val_ab = exdigits(\@digits, $start_a, $end_a) +
      exdigits(\@digits, $start_b, $end_b);
    my $start_c = $end_b + 1;
    foreach my $end_c ($start_c .. $#digits) {
      if ($val_ab == exdigits(\@digits, $start_c, $end_c)) {
        if ($end_c == $#digits) {
          return 1;
        } else {
          push @stack,[$start_b, $end_b, $end_c];
          last;
        }
      }
    }
  }
  return 0;
}
