#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maximumcount([-3, -2, -1, 1, 2, 3]), 3, 'example 1');
is(maximumcount([-2, -1, 0, 0, 1]), 2, 'example 2');
is(maximumcount([1, 2, 3, 4]), 4, 'example 3');

use List::Util qw(max);

sub maximumcount($a) {
  my $pos = 0;
  my $neg = 0;
  foreach my $n (@{$a}) {
    if ($n > 0) {
      $pos++;
    } elsif ($n < 0) {
      $neg++;
    }
  }
  max($pos, $neg);
}
