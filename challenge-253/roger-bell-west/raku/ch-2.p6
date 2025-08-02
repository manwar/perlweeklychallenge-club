#! /usr/bin/raku

use Test;

plan 2;

is-deeply(weakestrows([[1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1]]), [2, 0, 3, 1, 4], 'example 1');
is-deeply(weakestrows([[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]), [0, 2, 3, 1], 'example 2');

sub weakestrows(@aa) {
  my @p = (0 .. @aa.end);
  my @bb = @aa.map({$_.sum});
  @p = @p.sort({@bb[$^a] <=> @bb[$^b]});
  return @p;
}
