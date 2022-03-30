#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $M = 1000) {
   put gather {
      my $y = 1;
      while (my $p = 3 * $y * ($y + 1) + 1) <= $M {
         take $p if $p.is-prime;
         ++$y;
      }
   }.join(', '), '.';
}
