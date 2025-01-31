#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-306/#TASK2
#
# Task 2: Last Element
# ====================
#
# You are given a array of integers, @ints.
#
# Write a script to play a game where you pick two biggest integers in the
# given array, say x and y. Then do the following:
#
#   a) if x == y then remove both from the given array
#   b) if x != y then remove x and replace y with (y - x)
#
# At the end of the game, there is at most one element left.
#
# Return the last element if found otherwise return 0.
#
## Example 1
##
## Input: @ints = (3, 8, 5, 2, 9, 2)
## Output: 1
##
## Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
## Step 2: pick 3 and 5 => (2, 2, 1, 2)
## Step 3: pick 2 and 1 => (1, 2, 2)
## Step 4: pick 2 and 1 => (1, 2)
## Step 5: pick 1 and 2 => (1)
#
## Example 2
##
## Input: @ints = (3, 2, 5)
## Output: 0
##
## Step 1: pick 3 and 5 => (2, 2)
## Step 2: pick 2 and 2 => ()
#
############################################################
##
## discussion
##
############################################################
#
# There is a bit of ambiguity in the description that is clarified
# by the examples: if there are multiple elements of different value,
# but also multiple elements that are as big as the maximum element,
# then pick one of the biggest values and one of the second biggest,
# NOT two of the biggest. So from (2, 2, 1, 2) pick 2 and 1, not
# 2 and 2.
# With that clarified, we can now implement the whole thing: Search
# the two biggest values in the array, then handle them as layed out
# in the rules.
#

use v5.36;

last_element(3, 8, 5, 2, 9, 2);
last_element(3, 2, 5);

sub last_element(@ints) {
   say "Input: (" . join(",", @ints) . ")";
   while(@ints) {
      if(1 == scalar(@ints)) {
         say "Output: " . $ints[0];
         return;
      }
      my ($max1, $max2) = @ints[0..1];
      if($max1 < $max2) {
         ($max1, $max2) = ($max2, $max1);
      }
      foreach my $i (2..$#ints) {
         if($ints[$i] > $max1) {
            ($max1, $max2) = ($ints[$i], $max1);
         } elsif ($max1 == $max2) {
            $max2 = $ints[$i];
         } else {
            if($ints[$i] > $max2 && $ints[$i] < $max1) {
               $max2 = $ints[$i];
            }
         }
      }
      if($max1 == $max2) {
         # remove two occurences of $max1
         my @tmp = ();
         my $removed = 0;
         foreach my $elem (@ints) {
            if($elem == $max1 && $removed < 2) {
               $removed++;
               next;
            }
            push @tmp, $elem;
         }
         @ints = @tmp;
      } else {
         # remove max2, replace max1 with max1-max2
         my @tmp = ();
         my $new = $max1 - $max2;
         my $removed = 0;
         my $replaced = 0;
         foreach my $elem (@ints) {
            if($elem == $max1 && ! $removed) {
               $removed = 1;
               next;
            }
            if($elem == $max2 && ! $replaced) {
               push @tmp, $new;
               $replaced = 1;
               next;
            }
            push @tmp, $elem;
         }
         @ints = @tmp;
      }
   }
   say "Output: 0";
}
