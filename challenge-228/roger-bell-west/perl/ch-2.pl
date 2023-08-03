#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(emptyarray([3, 4, 2]), 5, 'example 1');
is(emptyarray([1, 2, 3]), 3, 'example 2');

use List::Util qw(min);

sub emptyarray($a0) {
  my $t = 0;
  my @a = @{$a0};
  while (scalar @a > 0) {
    my $mn = min(@a);
    foreach my $i (0..$#a) {
      if ($a[$i] == $mn) {
        $t += $i + 1;
        splice(@a, $i, 1);
        last;
      }
    }
  }
  return $t;
}
