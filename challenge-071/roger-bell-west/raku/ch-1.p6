#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(peaks((18, 45, 38, 25, 10, 7, 21, 6, 28, 48).List),
          (45, 21, 48),
          'peaks 1',
            );

is-deeply(peaks((47, 11, 32, 8, 1, 9, 39, 14, 36, 23).List),
          (47, 32, 39, 36),
          'peaks 2',
            );

sub genseq($n) {
  return (1..50).pick($n);
}

sub peaks(@list) {
  my @out;
  for (0..@list.end) -> $n {
    if (($n==0 || @list[$n] > @list[$n-1])
          &&
          ($n==@list.end || @list[$n] > @list[$n+1])) {
      push @out,@list[$n];
    }
  }
  return @out.flat;
}
