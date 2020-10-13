#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub is_interleaving ($A, $B, $C) {
   my ($lA, $lB, $lC) = map { length $_ } ($A, $B, $C);
   ($lA, $lB, $A, $B) = ($lB, $lA, $B, $A) if $lA > $lB;
   return 0 if ($lA + $lB != $lC) || ($lB > $lA + 1);
   my ($fA, $fB) = ($lA == $lB, 1); # can go first?
   for my $i (0 .. $lB - 1) {
      my ($cA, $cB) = map { substr $_, $i, 1 } ($A, $B);
      my $sC = substr $C, 2 * $i, 2;
      $fA &&= ($sC eq ($cA . $cB));
      $fB &&= ($sC eq ($cB . $cA));
      return 0 unless $fA || $fB;
   }
   return 1;
}

my $A = shift || 'XXY';
my $B = shift || 'XXZ';
my $C = shift || 'XXXXZY';
say is_interleaving($A, $B, $C);
