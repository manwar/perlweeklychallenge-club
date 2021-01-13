#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub isomorphic_strings ($A, $B) {
   return 0 if length($A) != length($B);
   my (%A_for, %B_for);
   for my $i (0 .. length($A) - 1) {
      my ($cA, $cB) = map { substr $_, $i, 1 } ($A, $B);
      return 0
        if (exists($B_for{$cA}) && ($B_for{$cA} ne $cB))
        || (exists($A_for{$cB}) && ($A_for{$cB} ne $cA));
      $B_for{$A_for{$cB} = $cA} = $cB;
   } ## end for my $i (0 .. length(...))
   return 1;
} ## end sub isomorphic_strings

{
   my $A = shift || 'abc';
   my $B = shift || 'xyz';
   say isomorphic_strings($A, $B);
}
