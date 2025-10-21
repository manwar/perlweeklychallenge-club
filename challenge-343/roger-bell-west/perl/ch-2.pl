#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]), 0, 'example 1');
is(championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]), 3, 'example 2');
is(championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]), 0, 'example 3');
is(championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]), 0, 'example 4');
is(championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]), 2, 'example 5');

use List::Util qw(sum);

sub championteam($a) {
  my $maxw = 0;
  my @teamw;
  while (my ($i, $w) = each @{$a}) {
    my $wins = sum(@{$w});
    if ($wins > $maxw) {
      @teamw = ();
      $maxw = $wins;
    }
    if ($wins == $maxw) {
      push @teamw, $i;
    }
  }
  if (scalar @teamw == 1) {
    return $teamw[0];
  }
  my $bestt = $teamw[0];
  foreach my $rt (@teamw) {
    if ($a->[$rt][$bestt] == 1) {
      $bestt = $rt;
    }
  }
  $bestt;
}
