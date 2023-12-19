#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(shortestdistance('loveleetcode', 'e'), [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0], 'example 1');
is_deeply(shortestdistance('aaab', 'b'), [3, 2, 1, 0], 'example 2');

sub shortestdistance($a, $c) {
  my @q;
  my $i = 0;
  while ($i >= 0) {
    my $p = index($a, $c, $i);
    if ($p > -1) {
      push @q, [$p, 0];
      $i = $p + 1;
    } else {
      $i = -1;
    }
  }
  my $invalid = length($a) + 1;
  my @out = ($invalid) x length($a);
  while (scalar @q) {
    my ($i, $v) = @{shift @q};
    if ($out[$i] == $invalid) {
      $out[$i] = $v;
      if ($i > 0) {
        push(@q, [$i - 1, $v + 1]);
      }
      if ($i < length($a) - 1) {
        push(@q, [$i + 1, $v + 1]);
      }
    }
  }
  return \@out;
}
