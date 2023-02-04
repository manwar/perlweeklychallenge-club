#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my ($n-streaks, $longest-streak) = consecutive-odds(@args);

   # strict
   $*ERR.put('(one single streak of exactly three odds, no other odd)');
   $*OUT.put(($n-streaks == 1 && $longest-streak == 3) ?? 1 !! 0);

   # lax
   $*ERR.put('at least three odds in a row');
   $*OUT.put(($longest-streak >= 3) ?? 1 !! 0);
}

sub consecutive-odds (@array) {
   my $longest-streak = 0;
   my $current-streak = 0;
   my $n-streaks = 0;
   for @array -> $item {
      if $item %% 2 {
         ++$n-streaks if $current-streak;
         $current-streak = 0;
      }
      else {
         ++$current-streak;
         ++$longest-streak if $longest-streak < $current-streak;
      }
   }
   ++$n-streaks if $current-streak;
   return $n-streaks, $longest-streak;
}
