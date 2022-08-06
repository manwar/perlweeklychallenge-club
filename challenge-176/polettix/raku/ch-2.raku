#!/usr/bin/env raku
use v6;

reversible-numbers().join(', ').put;

sub reversible-numbers {
   return gather {
      for 0 .. 4 -> $lo {
         my $hi = $lo + 1;
         while $hi <= 9 - $lo {
            take $lo * 10 + $hi if $lo;
            take $hi * 10 + $lo;
            $hi += 2;
         }
      }
   }.sort
}
