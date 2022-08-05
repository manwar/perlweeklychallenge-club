#!/usr/bin/env raku

sub reversible(Int $n) {
  $n + $n.comb.reverse.join andthen
    .comb.none %% 2
}

(1 ..^ 100)
  .grep: &reversible andthen
  .join: ', ' andthen
  .say;
