#! /usr/bin/raku

use Test;

plan 5;

is-deeply(smallerthancurrent([6, 5, 4, 8]), [2, 1, 0, 3], 'example 1');
is-deeply(smallerthancurrent([7, 7, 7, 7]), [0, 0, 0, 0], 'example 2');
is-deeply(smallerthancurrent([5, 4, 3, 2, 1]), [4, 3, 2, 1, 0], 'example 3');
is-deeply(smallerthancurrent([-1, 0, 3, -2, 1]), [1, 2, 4, 0, 3], 'example 4');
is-deeply(smallerthancurrent([0, 1, 1, 2, 0]), [0, 2, 2, 4, 0], 'example 5');

sub smallerthancurrent(@a) {
  my @b = @a.sort({$^a <=> $^b});
  my %m;
  for @b.kv -> $i, $v {
    unless (%m{$v}:exists) {
      %m{$v} = $i;
    }
  }
  return Array(@a.map({%m{$_}}));
}
