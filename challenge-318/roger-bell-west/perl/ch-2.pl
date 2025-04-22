#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(reverseequals([3, 2, 1, 4], [1, 2, 3, 4]), 1, 'example 1');
is(reverseequals([1, 3, 4], [4, 1, 3]), 0, 'example 2');
is(reverseequals([2], [2]), 1, 'example 3');

use Storable qw(dclone);

sub stringify($a) {
    join(';', map {"$_"} @{$a});
}

sub reverseequals($a, $b) {
  if (stringify($a) eq stringify($b)) {
    return 1;
  }
  foreach my $i (0 .. $#{$a} - 1) {
    foreach my $j ($i + 1 .. $#{$a}) {
      my $c = dclone($a);
      foreach my $x ($i .. $j) {
        $c->[$x] = $a->[$j - ($x - $i)];
      }
        if (stringify($c) eq stringify($b)) {
          return 1;
        }
    }
  }
  0;
}
