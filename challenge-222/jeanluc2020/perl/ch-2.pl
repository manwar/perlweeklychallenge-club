#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-222/#TASK2
#
# Task 2: Last Member
# ===================
#
# You are given an array of positive integers, @ints.
#
# Write a script to find the last member if found otherwise return 0. Each turn
# pick 2 biggest members (x, y) then decide based on the following conditions,
# continue this until you are left with 1 member or none.
#
###   a) if x == y then remove both members
#
###   b) if x != y then remove both members and add new member (y-x)
#
## Example 1:
##
## Input: @ints = (2, 7, 4, 1, 8, 1)
## Output: 1
##
## Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
## Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
## Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
## Step 4: pick 1 and 1, we remove both => (1).
#
## Example 2:
##
## Input: @ints = (1)
## Output: 1
#
## Example 3:
##
## Input: @ints = (1, 1)
## Output: 0
##
## Step 1: pick 1 and 1, we remove both and we left with none.
#
############################################################
##
## discussion
##
############################################################
#
# Since in each step, we remove the two biggest members, we can
# also remove the first two members of the list sorted in descending
# order. This makes things a bit easier.

use strict;
use warnings;

last_member(2, 7, 4, 1, 8, 1);
last_member(1);
last_member(1, 1);

sub last_member {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $count = scalar(@ints);
   while($count > 1) {
      my ($x, $y);
      ($x, $y, @ints) = sort { $b <=> $a } @ints;
      if($x > $y) {
         push @ints, ($x - $y);
      }
      $count = scalar(@ints);
   }
   print "Output: $count\n";
}
