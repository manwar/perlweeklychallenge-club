#!/usr/bin/env raku
use v6;
sub MAIN {
   my $candidate = 123456;
   loop {
      if check-permuted-multiples-upto6($candidate) {
         put $candidate;
         last;
      }
      ++$candidate;
   }
}

sub check-permuted-multiples-upto6 ($n) {
   my $baseline = $n.comb.Set;
   for 2 .. 6 -> $factor {
      my $candidate = ($n * $factor).comb.Set;
      return False if $candidate (^) $baseline;
   }
   return True;
}
