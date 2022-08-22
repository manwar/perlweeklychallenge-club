#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use utf8;
use List::Util qw(min max);

use Test::More tests => 2;

is(sparkline([0, 100]), "▁█", 'example 1');

is(sparkline([1, 2, 3, 4, 5, 6, 7, 8]), "▁▂▃▄▅▆▇█", 'example 1');

sub sparkline($nn) {
  my @bar = map {chr($_)} (0x2581..0x2588);
  my $mn = min(@{$nn});
  my $mx = max(@{$nn});
  my $inscale = $mx - $mn;
  my $outscale = scalar @bar;
  return join('',map {$bar[min(
    int(($_ - $mn) / $inscale * $outscale),
    $outscale - 1
      )]} @{$nn});
}
