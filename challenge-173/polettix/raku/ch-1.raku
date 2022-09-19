#!/usr/bin/env raku
use v6;
sub MAIN (*@candidates) {
   put is-esthetic($_) ?? "$_ is esthetic" !! "$_ is NOT esthetic"
      for @candidates;
   return 0;
}

sub is-esthetic ($candidate) {
   test-adjacents(-> $x, $y { abs($x - $y) == 1 }, $candidate.comb());
}

sub test-adjacents (&test, *@input) {
   for 1 ..^ @input -> $i {
      return False unless &test(|@input[$i - 1, $i]);
   }
   return True;
}
