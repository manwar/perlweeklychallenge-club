#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put kill-and-win(@args) }

sub kill-and-win-basic (@args) { return @args.sum }

sub kill-and-win (@args) {
   my $best-score = 0;
   my $score = 0;
   my $previous = 0;
   my $n-streak = 0;
   sub close-streak {
      return if $n-streak < 1;
      $score = $previous if $n-streak == 1; # "singleton"
      $best-score = $score if $score > $best-score;
      $score = 0;
      $n-streak = 0;
   }

   for @args.sort({$^a <=> $^b}) -> $item {
      close-streak() if $item > $previous + 1;
      $n-streak++    if $item > $previous;
      $score += $item;
      $previous = $item;
   }
   close-streak();

   return $best-score;
}
