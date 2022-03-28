#!/usr/bin/env raku

sub solve-quadratic($a, $b, $c) {
  (&[+], &[-]).map( -> &op { (- $b [&op] sqrt($b ** 2 - 4 * $a *$c))/(2 * $a) }).List
}

sub first-cuban($p) {
  solve-quadratic(3, 3, 1 - $p).any andthen $_ > 0 && .narrow ~~ Int
}
#`[
sub second-cuban($p) {
  solve-quadratic(3, 6, 4 - $p).any andthen $_ > 0 && .narrow ~~ Int
}
]
sub is-cuban($n) {
  .is-prime && (.&first-cuban#`[ || .&second-cuban]) given $n
}

(1..1000).grep(&is-cuban).join(', ').say;
