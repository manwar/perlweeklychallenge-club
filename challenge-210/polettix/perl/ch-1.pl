#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say kill_and_win(@ARGV);

sub kill_and_win (@args) {
   my $best_score = 0;
   my $score = 0;
   my $previous = 0;
   my $n_streak = 0;
   my $close_streak = sub {
      return if $n_streak < 1;  # should not happen
      $score = $previous if $n_streak == 1; # "singleton"
      $best_score = $score if $score > $best_score;
      $score = 0;
      $n_streak = 0;
   };

   for my $item (sort { $a <=> $b } @args) {
      $close_streak->() if $item > $previous + 1;
      $n_streak++       if $item > $previous;
      $score += $item;
      $previous = $item;
   }
   $close_streak->();

   return $best_score;
}
