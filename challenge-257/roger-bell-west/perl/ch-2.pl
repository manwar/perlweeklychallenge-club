#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 8;
use Test::Deep::NoTest;

is(reducedrowechelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]), 0, 'example 1');
is(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]), 1, 'example 2');
is(reducedrowechelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), 1, 'example 3');
is(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]), 0, 'example 4');
is(reducedrowechelon([[0, 1, 0], [0, 1, 0], [0, 0, 0]]), 0, 'example 5');
is(reducedrowechelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]), 0, 'example 6');
is(reducedrowechelon([[1, 0, 0, 4], [1, 0, 0, 7], [0, 0, 1, -1]]), 0, 'example 7');
is(reducedrowechelon([[1, -2, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), 0, 'example 8');

sub reducedrowechelon($a) {
  my @leadingone;
  foreach my $row (@{$a}) {
    my $lp = -1;
    foreach my $cn (0 .. $#{$row}) {
      my $cell = $row->[$cn];
      if ($cell == 1) {
        $lp = $cn;
        last;
      } elsif ($cell != 0) {
        return 0;
      }
    }
    push @leadingone, $lp;
  }
  while ($leadingone[-1] == -1) {
    pop @leadingone;
  }
  my @c = sort {$::a <=> $::b} @leadingone;
  if ($c[0] == -1) {
    return 0;
  }
  if (!eq_deeply(\@c, \@leadingone)) {
    return 0;
  }
  foreach my $i (@c) {
    my @col = sort {$::a <=> $::b} map {$_->[$i]} @{$a};
    if ($col[-1] != 1 ||
        $col[-2] != 0 ||
        $col[0] != 0) {
      return 0;
    }
  }
  return 1;
}
