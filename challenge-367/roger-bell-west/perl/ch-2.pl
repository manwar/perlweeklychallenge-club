#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(conflictevents(['10:00', '12:00'], ['11:00', '13:00']), 1, 'example 1');
is(conflictevents(['09:00', '10:30'], ['10:30', '12:00']), 0, 'example 2');
is(conflictevents(['14:00', '15:30'], ['14:30', '16:00']), 1, 'example 3');
is(conflictevents(['08:00', '09:00'], ['09:01', '10:00']), 0, 'example 4');
is(conflictevents(['23:30', '00:30'], ['00:00', '01:00']), 1, 'example 5');

sub parsetime($t) {
  my @p = split ':', $t;
  $p[0] * 60 + $p[1];
}

sub conflictevents($a, $b) {
  my @r;
  foreach my $t ($a, $b) {
    my $st = parsetime($t->[0]);
    my $en = parsetime($t->[1]);
    if ($st < $en) {
      push @r, [[ $st, $en - 1 ]];
    } else {
      push @r, [
        [ $st, 1440 - 1 ],
        [ 0, $en - 1 ],
          ];
    }
  }
  foreach my $ra (@{$r[0]}) {
    foreach my $rb (@{$r[1]}) {
      if ($ra->[0] <= $rb->[1] && $rb->[0] <= $ra->[1]) {
        return 1;
      }
    }
  }
  0;
}
