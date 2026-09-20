#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(arrangebox([[1, 3], [3, 5], [6, 8], [2, 4]]), 4, 'example 1');
is(arrangebox([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]), 3, 'example 2');
is(arrangebox([[5, 5], [5, 5], [5, 5]]), 1, 'example 3');
is(arrangebox([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]), 4, 'example 4');
is(arrangebox([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]), 3, 'example 5');

sub arrangebox($a0) {
  my @a = sort {
    $::a->[0] <=> $::b->[0] ||
      $::a->[1] <=> $::b->[1]
    } @{$a0};
  my @stack;
  my $mx = 1;
  foreach my $i (0 .. $#a) {
    push @stack,[$i, 1];
  }
  while (scalar @stack > 0) {
    my ($ix, $pm) = @{pop @stack};
    if ($pm > $mx) {
      $mx = $pm;
    }
    foreach my $j ($ix + 1 .. $#a) {
      if ($a[$ix][0] < $a[$j][0] && $a[$ix][1] < $a[$j][1]) {
        push @stack,[$j, $pm + 1];
      }
    }
  }
  $mx;
}
