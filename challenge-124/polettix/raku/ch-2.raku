#!/usr/bin/env raku
use v6;

constant \TOLERANCE = 1E-7;

my @input = @*ARGS ?? @*ARGS !! (1..10).map: * * 10;
my @subsets = tug-of-war(@input);
put 'Subset ', $_ + 1, ': (', @subsets[$_].join(', '), ')' for 0 .. 1;

sub tug-of-war (@set) {
   my $n = @set.elems; # number of elements in the set
   my $n_2 = $n %% 2 ?? $n / 2 !! ($n - 1) / 2; # size of "smaller" subset
   my $subset_target = @set.sum / 2;            # target "half" of sum
   my (@solution, $solution_delta);
   for @set.combinations($n_2) -> @subset {
      my $subset_delta = abs(@subset.sum - $subset_target);
      ($solution_delta, @solution) = ($subset_delta, |@subset)
         if (!defined($solution_delta)) || ($solution_delta > $subset_delta);
      last if $solution_delta < TOLERANCE;
   }
   return (@solution, (@set (-) @solution).keys);
}
