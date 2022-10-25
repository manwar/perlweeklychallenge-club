#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(totalzero(5, 4), 5, 'example 1');
is(totalzero(4, 6), 3, 'example 2');
is(totalzero(2, 5), 4, 'example 3');
is(totalzero(3, 1), 3, 'example 4');
is(totalzero(7, 4), 5, 'example 5');

sub totalzero($a, $b) {
  if ($a == 0 && $b == 0) {
    return 0;
  }
  my $ct = 1;
  while (1) {
    if ($a == $b) {
      return $ct;
    }
    $ct++;
    if ($a > $b) {
      $a -= $b;
    } else {
      $b -= $a;
    }
  }
}
