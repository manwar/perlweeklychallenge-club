#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(makingchange(9), 2, 'example 1');
is(makingchange(15), 6, 'example 2');
is(makingchange(100), 292, 'example 3');

sub cartesianproduct($lists) {
  my $sl = scalar @{$lists};
  my @c = (0) x $sl;
  my @cm = map {scalar @{$lists->[$_]} - 1} (0 .. $sl - 1);
  my @out;
  my $ex = 0;
  while (!$ex) {
    my @o;
    foreach my $i (0 .. $sl - 1) {
      push @o, $lists->[$i][$c[$i]];
    }
    push @out, \@o;
    my $ss = $sl - 1;
    while (1) {
      $c[$ss]++;
      if ($c[$ss] > $cm[$ss]) {
        if ($ss == 0) {
          $ex = 1;
          last;
        }
        $c[$ss] = 0;
        $ss--;
      } else {
        last;
      }
    }
  }
  return \@out;
}

sub makingchange($a) {
  my @coins = (1, 5, 10, 25, 50);
  my @mx = map {int($a / $_)} @coins;
  my @pat;
  foreach my $i (0 .. $#coins) {
    if ($mx[$i] > 0) {
        push @pat, [0 .. $mx[$i]];
    } else {
      last;
    }
  }
  my $ct;
  foreach my $combo (@{cartesianproduct(\@pat)}) {
    my $t = 0;
    while (my ($i, $c) = each @{$combo}) {
      $t += $c * $coins[$i];
      if ($t > $a) {
        last;
      }
    }
      if ($t == $a) {
        $ct++;
      }
  }
  return $ct;
}
