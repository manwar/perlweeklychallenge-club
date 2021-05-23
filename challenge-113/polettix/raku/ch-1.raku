#!/usr/bin/env raku
use v6;

sub represent-integer (Int $n is copy, Int $d) {
   return 0 if $n < $d;
   return 1 if $n >= 10 * $d;
   return 1 if $n ~~ m{$d};
   $n -= $d;
   while $n > 0 {
      return 1 if represent-integer($n, $d);
      $n -= 10;
   }
   return 0;
}

sub MAIN ($N = 25, $D = 7) { represent-integer($N, $D).say }
