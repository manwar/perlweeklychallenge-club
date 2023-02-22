#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maximumxor([1, 2, 3, 4, 5, 6, 7]), 7, 'example 1');
is(maximumxor([2, 4, 1, 3]), 7, 'example 2');
is(maximumxor([10, 5, 7, 12, 8]), 15, 'example 3');

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(max);

sub maximumxor($l) {
  my @m;
  my $i = combinations($l, 2);
  while (my $c = $i->next) {
    push @m, $c->[0] ^ $c->[1];
  }
  return max(@m);
}
