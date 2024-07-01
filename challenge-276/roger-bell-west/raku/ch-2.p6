#! /usr/bin/raku

use Test;

plan 2;

is(maximumfrequency([1, 2, 2, 4, 1, 5]), 4, 'example 1');
is(maximumfrequency([1, 2, 3, 4, 5]), 5, 'example 2');

sub maximumfrequency(@a) {
  my %c;
  for @a -> $n {
    %c{$n}++;
  }
  my $mx = %c.values.max;
  return $mx * %c.values.grep({$_ == $mx}).elems;
}
