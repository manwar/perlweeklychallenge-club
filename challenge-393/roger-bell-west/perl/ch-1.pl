#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(pythagorasmultiplied(20), 12, 'example 1');
is(pythagorasmultiplied(7), 2, 'example 2');
is(pythagorasmultiplied(1), 0, 'example 3');
is(pythagorasmultiplied(15), 8, 'example 4');
is(pythagorasmultiplied(30), 22, 'example 5');

use Memoize;

memoize('squared');

sub squared($a) {
  $a * $a;
}

sub pythagorasmultiplied($n) {
  my $ct = 0;
  foreach my $c (5 .. $n) {
    my $csquared = squared($c);
    foreach my $a (1 .. $c - 2) {
      my $asquared = squared($a);
      foreach my $b ($a + 1 .. $c - 1) {
        my $bsquared = squared($b);
        my $tot = $asquared + $bsquared;
        if ($tot > $csquared) {
          last;
        }
        if ($tot == $csquared) {
          $ct += 1;
        }
      }
    }
  }
  $ct * 2;
}
