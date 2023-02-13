#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(specialquads([1, 2, 3, 6]), 1, 'example 1');
is(specialquads([1, 1, 1, 3, 5]), 4, 'example 2');
is(specialquads([3, 3, 6, 4, 5]), 0, 'example 3');

use Algorithm::Combinatorics qw(combinations);

sub specialquads($l) {
  my $ct = 0;
  my $i = combinations($l, 4);
  while (my $c = $i->next) {
    if ($c->[0] + $c->[1] + $c->[2] == $c->[3]) {
      $ct++;
    }
  }
  return $ct;
}
