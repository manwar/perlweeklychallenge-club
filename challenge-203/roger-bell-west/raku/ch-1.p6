#! /usr/bin/raku

use Test;

plan 3;

is(specialquads([1, 2, 3, 6]), 1, 'example 1');
is(specialquads([1, 1, 1, 3, 5]), 4, 'example 2');
is(specialquads([3, 3, 6, 4, 5]), 0, 'example 3');

sub specialquads(@l) {
  my $ct = 0;
  for @l.combinations(4) -> @c {
    if (@c[0] + @c[1] + @c[2] == @c[3]) {
      $ct++;
    }
  }
  return $ct;
}
