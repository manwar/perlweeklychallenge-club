#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/#TASK2
#
# A Knight in chess can move from its current position to any square two rows
# or columns plus one column or row away. So in the diagram below, if it starts
# a S, it can move to any of the squares marked E.
#
# Write a script which takes a starting position and an ending position and
# calculates the least number of moves required.
#
# https://theweeklychallenge.org/images/blog/week_281_task_2.png
#
## Example 1
##
## Input: $start = 'g2', $end = 'a8'
## Ouput: 4
##
## g2 -> e3 -> d5 -> c7 -> a8
#
## Example 2
##
## Input: $start = 'g2', $end = 'h2'
## Ouput: 3
##
## g2 -> e3 -> f1 -> h2
#
############################################################
##
## discussion
##
############################################################
#
# Some observations:
# 1. The shortest path from one square to the directly neighboring
#    square has length 5
#    Example: a8->c7->e6->d8->c6->b8 (for all other combinations
#    it's just shifted around, mirrored, or rotated by 90°)
# 2. The shortest path from one square to its diagonal neighboar has
#    length 2, except if it's in the corner (a8->b7 is one move to
#    b6 or c7, then it's a case of walking to the directly neighboring
#    square, so the length is 1+5=6 in this case)
# 3. The shortest path to cover most of the distance on the board from
#    one end to the next (or the opposing corner) is basically 4, plus
#    some more steps to jump to the exact square you want to end up in
# From this, we can assume there is an upper limit of how many steps are
# required to go from any square to any other square: 4+6=10 steps
# should be enough in any case.
# So we can brute-force this with a max-depth of 10.

use strict;
use warnings;
use List::Util qw(min any);

knights_move("g2", "a8");
knights_move("g2", "h2");

sub knights_move {
   my ($start, $end) = @_;
   print "Input: $start -> $end\n";
   my $l = min_length($start, $end, 1, []);
   print "Output: $l\n";
}

sub min_length {
   my ($start, $end, $step, $seen) = @_;
   # print "=> [" . join(",", @$seen) . "] $start, $end, $step\n";
   if($start eq $end) {
      return 0;
   }
   if($step > 10 || any { $_ eq $start} @$seen) {
      return 1000;
   }
   my $map = { "a" => 1, "b" => 2, "c" => 3, "d" => 4,
      "e" => 5, "f" => 6, "g" => 7, "h" => 8 };
   my $reverse_map = { 1 => "a", 2 => "b", 3 => "c", 4 => "d",
      5 => "e", 6 => "f", 7 => "g", 8 => "h" };
   my ($char1, $digit1) = split //, $start;
   my ($char2, $digit2) = split //, $end;
   my @lengths = ();
   foreach my $direction ( ([-2, 1], [-2,-1], [-1,-2], [-1,2],
      [2,1], [2,-1], [1,2], [1,-2]) ) {
        my $c = $map->{$char1} + $direction->[0];
        my $d = $digit1 + $direction->[1];
        if(legal( $c, $d)) {
           next if any  { $_ eq $start} @$seen;
           my $l = 1 + min_length($reverse_map->{$c} . $d, $end, $step+1, [@$seen, $start] );
           next unless $l;
           push @lengths, $l if $l < 1000;
        }
   }
   return min(@lengths, 1000);
}

sub legal {
   my ($mapped_digit, $digit) = @_;
   if($mapped_digit < 1 || $digit < 1) {
      return 0;
   }
   if($mapped_digit > 8 || $digit > 8) {
      return 0;
   }
   return 1;
}
