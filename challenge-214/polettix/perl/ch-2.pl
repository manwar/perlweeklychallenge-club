#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use Memoize 'memoize';
use Data::Dumper;

say collect_points(@ARGV ? @ARGV : (2, 4, 4, 3, 4, 4, 3, 3, 3, 3, 5, 3));

sub collect_points (@numbers) {
   return 0 unless @numbers;
   my @slots = ($numbers[0], 1);
   for my $i (1 .. $#numbers) {
      if ($numbers[$i - 1] == $numbers[$i]) {
         $slots[-1]++;
      }
      else {
         push @slots, $numbers[$i], 1;
      }
   }
   return collect_points_wh(@slots);
}

sub remove_slot ($i, @slots) {
   splice(@slots, $i, 2);

   # check for merge
   if ($i > 0 && $i < @slots && $slots[$i - 2] == $slots[$i]) {
      $slots[$i - 1] += $slots[$i + 1];
      splice(@slots, $i, 2);
   }

   return @slots;
}

sub collect_points_wh (@slots) {
   my $score = 0;

   while ('necessary') {
      my %count_for;

      my $i = 0;
      while ($i < @slots) {
         ($count_for{$slots[$i]} //= 0)++;
         $i += 2;
      }

      my %is_single = map { $_ => 1 }
         grep { $count_for{$_} == 1 } keys %count_for;
      last unless scalar keys %is_single;

      $i = 0;
      while ($i < @slots) {
         if ($is_single{$slots[$i]}) {
            $score += $slots[$i + 1] ** 2;
            @slots = remove_slot($i, @slots);
         }
         else {
            $i += 2;
         }
      }
   }

   my $i = 0;
   my $best_sub_score = 0;
   while ($i < @slots) {
      my @sub_slots = remove_slot($i, @slots);
      my $sub_score = collect_points_wh(@sub_slots);
      $best_sub_score = $sub_score if $best_sub_score < $sub_score;
      $i += 2;
   }

   $score += $best_sub_score;
   return $score;
}
