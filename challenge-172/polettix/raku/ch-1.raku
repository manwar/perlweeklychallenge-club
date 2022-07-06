#!/usr/bin/env raku
use v6;
sub MAIN ($n = 18, $m = 2) { say prime-partition($n, $m) }

multi sub prime-partition ($n where *.is-prime, 1) { [ $n ] }
multi sub prime-partition ($n, 1) { [] }
multi sub prime-partition ($n, $m) {
   for (2 .. $n - 2).grep({.is-prime}).combinations($m) -> $c {
      return $c.Array if $c.sum == $n;
   }
   return [];
}
