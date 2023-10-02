#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(lexicographic(['abc', 'bce', 'cae']), 1, 'example 1');
is(lexicographic(['yxz', 'cba', 'mon']), 2, 'example 2');

sub lexicographic($a) {
  my $t = 0;
  foreach my $st (@{$a}) {
    my @q = sort split '',$st;
    if (join('', @q) eq $st) {
      next;
    }
    @q = reverse @q;
    if (join('', @q) eq $st) {
      next;
    }
    $t++;
  }
  return $t;
}
