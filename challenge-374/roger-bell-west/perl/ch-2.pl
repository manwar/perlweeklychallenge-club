#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(largestsamedigitsnumber('6777133339'), 3333, 'example 1');
is(largestsamedigitsnumber('1200034'), 4, 'example 2');
is(largestsamedigitsnumber('44221155'), 55, 'example 3');
is(largestsamedigitsnumber('88888'), 88888, 'example 4');
is(largestsamedigitsnumber('11122233'), 222, 'example 5');

sub largestsamedigitsnumber($a) {
  foreach my $l (reverse (1 .. length($a))) {
    foreach my $n (reverse (1 .. 9)) {
      my $test = $n x $l;
      if (index($a, $test) > -1) {
        return 0 + $test;
      }
    }
  }
  0;
}
