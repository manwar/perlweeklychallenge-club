#!/usr/bin/env perl6

#| Find the first square number with at least <digits> unique digits
unit sub MAIN(
  #| Number of digits, in the range 1..10 (default 5)
  Int $digits where 1..10 = 5
);

(^∞).map(* ** 2).grep(*.comb.Bag.elems >= $digits)[0].put;
