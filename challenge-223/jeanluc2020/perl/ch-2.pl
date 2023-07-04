#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-223/#TASK2
#
# Task 2: Box Coins
# =================
#
# You are given an array representing box coins, @box.
#
# Write a script to collect the maximum coins until you took out all boxes. If
# we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1]. If
# $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.
#
## Example 1:
##
## Input: @box = (3, 1, 5, 8)
## Output: 167
##
## Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).
## Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).
## Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).
## Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No more box available.
#
## Example 2:
##
## Input: @box = (1, 5)
## Output: 10
##
## Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).
## Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No more box available.
#
############################################################
##
## discussion
##
############################################################
#
# To find the maximum, we basically try to take each index, collect the coins, and
# run recursively with what remains to find the maximum.

use strict;
use warnings;

box_coins(3, 1, 5, 8);
box_coins(1, 5);

sub box_coins {
   my @box = @_;
   print "Input: (" . join(", ", @box) . ")\n";
   print "Output: " . box_coins_recursive(@box) . "\n";
}

sub box_coins_recursive {
   my @box = @_;
   my $elements = scalar(@box);
   if($elements == 0) {
      return 0;
   }
   if($elements == 1) {
      return $box[0];
   }
   my $max = 0;
   foreach my $index (0..$#box) {
      my $prod = 1;
      if($index > 0) {
         $prod = $box[$index-1];
      }
      $prod *= $box[$index];
      if($index < $#box) {
         $prod *= $box[$index+1];
      }
      my $this = $prod + box_coins_recursive(@box[0..$index-1], @box[$index+1..$#box]);
      $max = $this if $this > $max;
   }
   return $max;
}
