#! /usr/bin/raku

use Test;

plan 2;

is(alphanumericstringvalue(['perl', "2", "000", 'python', 'raku']), 6, 'example 1');
is(alphanumericstringvalue(["001", "1", "000", "0001"]), 1, 'example 2');

sub alphanumericstringvalue(@a) {
  my @l;
  for @a -> $n {
    if ($n ~~ /^\d+$/) {
      push @l, 0 + $n;
    } else {
      push @l, $n.chars;
    }
  }
  return @l.max;
}
