#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(concatenationvalue([6, 12, 25, 1]), 1286, 'example 1');
is(concatenationvalue([10, 7, 31, 5, 2, 2]), 489, 'example 2');
is(concatenationvalue([1, 2, 10]), 112, 'example 3');

sub concat($a0, $b0) {
  if ($b0 == 0) {
    return 10 * $a0;
  }
  my $a = $a0;
  my $b = $b0;
  while ($b > 0) {
    $a *= 10;
    $b = int($b/10);
  }
  return $a + $b0;
}

sub concatenationvalue($a) {
  my $t = 0;
  foreach my $i (0 .. int($#{$a} / 2)) {
    my $j = $#{$a} - $i;
    if ($j == $i) {
      $t += $a->[$i];
    } else {
      $t += concat($a->[$i], $a->[$j]);
    }
  }
  return $t;
}
