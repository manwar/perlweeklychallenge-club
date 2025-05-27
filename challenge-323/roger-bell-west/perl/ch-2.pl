#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(taxamount(10, [[3, 50], [7, 10], [12, 25]]), 2.65, 'example 1');
is(taxamount(2, [[1, 0], [4, 25], [5, 50]]), 0.25, 'example 2');
is(taxamount(0, [[2, 50]]), 0, 'example 3');

use List::Util qw(min);

sub taxamount($income, $brackets) {
  my $tax = 0;
  my $lastbracket = 0;
  foreach my $bracket (@{$brackets}) {
    if ($income > $lastbracket) {
      $tax += (min($income, $bracket->[0]) - $lastbracket) * $bracket->[1];
    } else {
      last;
    }
    $lastbracket = $bracket->[0];
  }
  $tax / 100;
}
