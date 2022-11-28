#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(binarystring(2), ["00", "01", "10", "11"], 'example 1');
is-deeply(binarystring(3), ["000", "001", "010", "011", "100", "101", "110", "111"], 'example 2');

sub binarystring($n) {
  my @o;
  for (0..(1 +< $n)-1) -> $a {
    @o.push(sprintf('%0' ~ $n ~ 'b', $a));
  }
  return @o;
}
