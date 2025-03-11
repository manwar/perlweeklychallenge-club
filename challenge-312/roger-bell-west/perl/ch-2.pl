#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(ballsandboxes('G0B1R2R0B0'), 1, 'example 1');
is(ballsandboxes('G1R3R6B3G6B1B6R1G3'), 3, 'example 2');
is(ballsandboxes('B3B2G1B3'), 0, 'example 3');

sub ballsandboxes($a) {
  my %boxes;
  my $colour = '@';
  my @cc = split '', $a;
  while (my ($i, $c) = each @cc) {
    if ($i % 2 == 0) {
      $colour = $c;
    } else {
      $boxes{0 + $c}{$colour} = 1;
    }
  }
  scalar grep {scalar keys %{$_} >= 3}values %boxes;
}
