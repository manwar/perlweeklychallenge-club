#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(digitalroot(38), [2, 2], 'example 1');
is_deeply(digitalroot(7), [0, 7], 'example 2');
is_deeply(digitalroot(999), [2, 9], 'example 3');
is_deeply(digitalroot(1999999999), [3, 1], 'example 4');
is_deeply(digitalroot(101010), [1, 3], 'example 5');

sub digitalroot($a) {
  my $count = 0;
  my $value = $a;
  while ($value > 9) {
    my $p = 0;
    while ($value > 0) {
      $p += $value % 10;
      $value = int($value / 10);
    }
    $value = $p;
    $count++;
  }
  [$count, $value];
}
