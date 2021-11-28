#!/usr/bin/env raku
use v6;
sub MAIN (Int $N is copy = 5) {
   my $p = 2;
   while ($N > 0) {
      if (is-long-prime($p)) {
         $p.put;
         --$N;
      }
      $p++;
   }
}
sub is-long-prime (Int:D $n where * > 0) {
   return False unless (10 % $n) && $n.is-prime;
   my $num = 1 ~ 0 x $n.chars;
   my %seen;
   $num = 10 * ($num % $n) while ! %seen{$num}++;
   return $n - 1 == %seen.elems;
}
