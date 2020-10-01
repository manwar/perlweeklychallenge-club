#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util qw< max sum >;

sub candies_for_candidates (@N) {
   return unless @N;

   my @candies = (1) x @N; # everybody gets a candy!
   push @N, max($N[0], $N[-1]) + 1; # add "edge" value to simplify loops

   while ('necessary') {
      my $something_changed = 0;
      for my $i (0 .. $#candies) {
         for my $delta (-1, 1) {
            next if $N[$i] <= $N[$i + $delta];
            next if $candies[$i] > $candies[$i + $delta];
            $candies[$i] = $candies[$i + $delta] + 1;
            $something_changed = 1;
         }
      }
      last unless $something_changed;
   }
   return sum @candies;
}

for my $test (
   [ 1, 2, 2 ],
   [ 1, 3, 4, 1 ],
   [ 7, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6, 7 ],
   ) {
   say candies_for_candidates($test->@*);
}
