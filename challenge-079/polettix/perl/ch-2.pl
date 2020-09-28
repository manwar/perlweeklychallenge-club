#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util qw< min max >;

sub trapped_rain_water (@N) {
   my $max = 0;
   my @maxes;

   # first pass, left to right
   for my $v (@N) {
      $max = max($max, $v);
      push @maxes, $max;
   }

   # second pass, right to left
   my $retval = 0;
   $max = 0;
   for my $v (reverse @N) {
      $max = max($max, $v);
      my $w = min($max, shift @maxes);
      $retval += $w - $v;
   }
   return $retval;
}

sub trapped_rain_water_dumb (@N) {
   my $retval = 0;
   for my $i (1 .. $#N - 1) {
      my $max_left  = max(@N[0 .. $i]);
      my $max_right = max(@N[$i .. $#N]);
      my $min_max   = min($max_left, $max_right);
      $retval += $min_max - $N[$i];
   }
   return $retval;
}


say trapped_rain_water_dumb(2, 1, 4, 1, 2, 5);
say trapped_rain_water_dumb(3, 1, 3, 1, 1, 5);
