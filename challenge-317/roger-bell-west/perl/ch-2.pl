#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(friendlystrings('desc', 'dsec'), 1, 'example 1');
is(friendlystrings('fuck', 'fcuk'), 1, 'example 2');
is(friendlystrings('poo', 'eop'), 0, 'example 3');
is(friendlystrings('stripe', 'sprite'), 1, 'example 4');

sub friendlystrings($a, $b) {
  foreach my $i (0 ..  length($a) - 2) {
    foreach my $j ($i + 1 ..  length($a) - 1) {
      my $c = $a;
      substr($c, $i, 1) = substr($a, $j, 1);
      substr($c, $j, 1) = substr($a, $i, 1);
      if ($c eq $b) {
        return 1;
      }
    }
  }
  0;
}
