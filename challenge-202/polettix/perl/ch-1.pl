#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my ($n_streaks, $longest_streak) = consecutive_odds(@ARGV);

# strict
say {*STDERR} '(one single streak of exactly three odds, no other odd)';
say {*STDOUT} $n_streaks == 1 && $longest_streak == 3 ? 1 : 0;

# lax
say {*STDERR} 'at least three odds in a row';
say {*STDOUT} $longest_streak >= 3 ? 1 : 0;

sub consecutive_odds (@array) {
   my $longest_streak = 0;
   my $current_streak = 0;
   my $n_streaks = 0;
   for my $item (@array) {
      if ($item % 2) {
         ++$current_streak;
         ++$longest_streak if $longest_streak < $current_streak;
      }
      else {
         ++$n_streaks if $current_streak;
         $current_streak = 0;
      }
   }
   ++$n_streaks if $current_streak;
   return ($n_streaks, $longest_streak);
}
