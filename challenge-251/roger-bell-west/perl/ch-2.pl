#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(luckynumbers([[3, 7, 9], [9, 11, 13], [15, 16, 17]]), 15, 'example 1');
is(luckynumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]), 12, 'example 2');
is(luckynumbers([[7, 8], [1, 2]]), 7, 'example 3');

use Storable qw(freeze thaw);

sub luckynumbers($a) {
  my $maxs = {};
  foreach my $x (0 .. $#{$a->[0]}) {
    my $max = [0, 0, 0];
    foreach my $y (0 .. $#{$a}) {
      if ($a->[$y][$x] > $max->[0]) {
        $max = [$a->[$y][$x], $y, $x];
      }
    }
    $maxs->{freeze($max)} = 1;
  }
  my $mins = {};
  foreach my $y (0 .. $#{$a}) {
    my $min = [$a->[$y][0], $y, 0];
    foreach my $x (0 .. $#{$a->[0]}) {
      if ($a->[$y][$x] < $min->[0]) {
        $min = [$a->[$y][$x], $y, $x];
      }
    }
    $mins->{freeze($min)} = 1;
  }
  foreach my $i (keys %{$maxs}) {
    if (exists $mins->{$i}) {
      return thaw($i)->[0];
    }
  }
  return -1;
}
