#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(onesandzeroes(['10', '0001', '111001', '1', '0'], 5, 3), 4, 'example 1');
is(onesandzeroes(['10', '1', '0'], 1, 1), 2, 'example 2');

use List::Util qw(max);

sub onesandzeroes($a, $zeroes, $ones) {
  my @ax;
  foreach my $ns (@{$a}) {
    my $o = 0;
    my $n = 0;
    foreach my $c (split '', $ns) {
      if ($c eq '0') {
        $o++;
      } elsif ($c eq '1') {
        $n++;
      }
    }
    push @ax,[$o, $n];
  }
  my $mx = 0;
  foreach my $mask (1 .. (1 << scalar @ax) - 1) {
    my $o = 0;
    my $n = 0;
    my $ct = 0;
    keys @ax;
    while (my ($i, $x) = each @ax) {
      if ($mask & (1 << $i)) {
        $o += $x->[0];
        $n += $x->[1];
        $ct++;
        if ($o > $zeroes || $n > $ones) {
          last;
        }
      }
    }
    if ($o <= $zeroes && $n <= $ones) {
      $mx = max($mx, $ct);
    }
  }
  $mx;
}
