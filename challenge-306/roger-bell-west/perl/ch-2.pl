#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(lastelement([3, 8, 5, 2, 9, 2]), 1, 'example 1');
is(lastelement([3, 2, 5]), 0, 'example 2');

sub lastelement($a) {
  my @b = @{$a};
  while (1) {
    @b = sort {$::a <=> $::b} @b;
    my $f = pop @b;
    my $s = pop @b;
    if ($f > $s) {
      push @b, $f - $s;
    }
    if (scalar @b == 0) {
      return 0;
    }
    if (scalar @b == 1) {
      return $b[0];
    }
  }
}
