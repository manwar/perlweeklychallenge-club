#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ', ', reversible_numbers();

sub reversible_numbers {
   my @retval;
   for my $lo (0 .. 4) {
      for (my $hi = $lo + 1; $hi <= 9 - $lo; $hi += 2) {
         push @retval, $lo * 10 + $hi if $lo;
         push @retval, $hi * 10 + $lo;
      }
   }
   return sort { $a <=> $b } @retval;
}
