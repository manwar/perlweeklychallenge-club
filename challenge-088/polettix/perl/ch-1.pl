#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub array_of_product (@N) {
   my $p = 1;
   $p *= $_ for @N[0 .. $#N - 1];
   return map {$p = $N[$_ - 1] * ($p / $N[$_]) } 0 .. $#N;
}

sub array_of_product_sloppy (@N) {
   return map {
      my $p = 1;
      $p *= $_ for @N[0 .. $_ - 1, $_ + 1 .. $#N];
      $p;
   } 0 .. $#N;
}

sub array_of_product_overflowing (@N) {
   my $p = 1;
   $p *= $_ for @N;
   return map {$p / $_ } @N;
}

sub print_array (@A) { local $" = ', '; say "(@A)" }

print_array(array_of_product(@ARGV ? @ARGV : (5, 2, 1, 4, 3)));
print_array(array_of_product_sloppy(@ARGV ? @ARGV : (5, 2, 1, 4, 3)));
print_array(array_of_product_overflowing(@ARGV ? @ARGV : (5, 2, 1, 4, 3)));
