#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n = 5) {
   for 1 .. $n -> $b {
      my $a = 3 * $b - 1;
      my $c = 8 * $b - 3;

      my $sqrt = $b * $c.sqrt;
      my $first = ($a + $sqrt) ** (1 / 3);
      my $second = ($sqrt - $a) ** (1 / 3);
      my $result = $first - $second;

      "($a, $b, $c) -> $result".put;
   }
}
