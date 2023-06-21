#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(lastmember([2, 7, 4, 1, 8, 1]), 1, 'example 1');
is(lastmember([1]), 1, 'example 2');
is(lastmember([1, 1]), 0, 'example 3');

sub lastmember($a0) {
  my @a = @{$a0};
  while (scalar @a > 1) {
    @a = sort @a;
    my $x = pop @a;
    my $y = pop @a;
    if ($x != $y) {
      push @a, $x - $y;
    }
  }
  if (scalar @a == 0) {
    return 0;
  } else {
    return $a[0];
  }
}
