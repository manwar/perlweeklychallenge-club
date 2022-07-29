#!/usr/bin/env raku

use experimental :cached; 

sub totient($n) is cached {
  (1 ..^ $n)
    .grep: * gcd $n == 1 andthen
    .elems
}

sub iterated-totient-sum($n) {
  $n, *.&totient ... 1 andthen
    .skip
    .sum
}

(1 .. *)
  .grep: { .&iterated-totient-sum == $_} andthen
  .head: 20 andthen
  .join: ', ' andthen
  .say;