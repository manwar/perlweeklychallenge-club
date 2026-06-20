#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

is(sumofwords('acb', 'cba', 'cdb'), 1, 'example 1');
is(sumofwords('aab', 'aac', 'ad'), 1, 'example 2');
is(sumofwords('bc', 'je', 'jg'), 0, 'example 3');
is(sumofwords('a', 'aaaa', 'aa'), 1, 'example 4');
is(sumofwords('c', 'd', 'h'), 0, 'example 5');
is(sumofwords('gfi', 'hbf', 'bdhd'), 1, 'example 6');

sub l2n($a) {
  my $a0 = ord('a');
  my $t = 0;
  foreach my $c (split '', $a) {
    $t *= 10;
    $t += ord($c) - $a0;
  }
  $t;
}

sub sumofwords($a, $b, $c) {
  (l2n($a) + l2n($b) == l2n($c))?1:0;
}
