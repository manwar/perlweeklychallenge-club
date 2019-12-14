#!/usr/bin/env perl6

constant %values = (
  1  => 'AGISUXZ'.comb,
  2  => 'EJLRVY'.comb,
  3  => <F D P W>,
  4  => <B N>,
  5  => 'TOHMC'.comb,
  10 => <K Q>,
).invert;

constant %tiles = (
  :8A, :5B, :4C, :3D,
  :9E, :3F, :3G, :5H,
  :5I, :3J, :5K, :3L,
  :5M, :4N, :5O, :5P,
  :4Q, :3R, :7S, :3T,
  :5U, :3V, :5W, :2X,
  :5Y, :5Z,
).Bag;

sub MAIN (--> Nil) {
  given %tiles.pick(7).Bag -> %picked {
    "Tiles: %picked.kxxv.join()".say;
    # source: https://www.wordgamedictionary.com/sowpods/download/sowpods.txt
    "Winner: $_.key() for $_.value()".say with
      $?FILE.IO.parent.add('sowpods.txt').slurp.uc.words
      .grep({ .chars ≤ %picked.elems && .comb ⊆ %picked })
      .map(sub {
        given $^a => $a.comb.map({ %values{$_} }).sum {
          .say;
          .return;
        }
      }).sort({ $^b.value <=> $^a.value }).first;
  }
}
