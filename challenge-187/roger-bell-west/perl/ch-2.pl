#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

use Algorithm::Combinatorics qw(combinations);

is_deeply(magicaltriplets([1, 2, 3, 2]),
          [3, 2, 2],
          'example 1');

is_deeply(magicaltriplets([1, 3, 2]),
          [],
          'example 2');

is_deeply(magicaltriplets([1, 1, 2, 3]),
          [],
          'example 3');

is_deeply(magicaltriplets([2, 4, 3]),
          [4, 3, 2],
          'example 4');

sub magicaltriplets($a) {
  my $out = [];
  my $mv = 0;
  my $iter = combinations($a, 3);
  while (my $b = $iter->next) {
    if ($b->[0] + $b->[1] > $b->[2] &&
        $b->[1] + $b->[2] > $b->[0] &&
        $b->[0] + $b->[2] > $b->[1]) {
      my $v = $b->[0] + $b->[1] + $b->[2];
      if ($v > $mv) {
        $mv = $v;
        $out = [$b->[0], $b->[1], $b->[2]];
      }
    }
  }
  return [reverse sort @{$out}];
}
