#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub pair_difference ($A, @N) {
   $A = -$A if $A < 0;
   for my $i (0 .. $#N - 1) {
      for my $j ($i + 1 .. $#N) {
         return 1 if abs($N[$i] - $N[$j]) == $A;
      }
   }
   return 0;
}

sub main ($A = 7, @N) { say pair_difference($A, @N) }

main(@ARGV);
