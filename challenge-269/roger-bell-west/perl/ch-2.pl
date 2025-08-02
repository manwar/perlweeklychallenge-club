#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(distributeelements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1], 'example 1');
is_deeply(distributeelements([3, 2, 4]), [3, 4, 2], 'example 2');
is_deeply(distributeelements([5, 4, 3, 8]), [5, 3, 4, 8], 'example 3');

sub distributeelements($a) {
  my @x = ($a->[0]);
  my @y = ($a->[1]);
  foreach my $i (2 .. $#{$a}) {
    my $n = $a->[$i];
    if ($x[-1] > $y[-1]) {
      push @x, $n;
    } else {
      push @y, $n;
    }
  }
  use YAML::XS;
  push @x, @y;
  return \@x;
}
