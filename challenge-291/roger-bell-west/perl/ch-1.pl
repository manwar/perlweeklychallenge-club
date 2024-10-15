#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(middleindex([2, 3, -1, 8, 4]), 3, 'example 1');
is(middleindex([1, -1, 4]), 2, 'example 2');
is(middleindex([2, 5]), -1, 'example 3');

use List::Util qw(sum);

sub middleindex($a) {
  my $r = sum(@{$a});
  my $l = 0;
  while (my ($i, $c) = each @{$a}) {
    $r -= $c;
    if ($r == $l) {
      return $i;
    }
    $l += $c;
  }
  -1;
}
