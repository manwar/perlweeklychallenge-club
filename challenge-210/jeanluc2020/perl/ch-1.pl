#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-210/#TASK1
#
# Task 1: Kill and Win
# ====================
#
# You are given a list of integers.
#
# Write a script to get the maximum points. You are allowed to take out (kill)
# any integer and remove from the list. However if you do that then all
# integers exactly one-less or one-more would also be removed. Find out the
# total of integers removed.
#
## Example 1
##
## Input: @int = (2, 3, 1)
## Output: 6
##
## First we delete 2 and that would also delete 1 and 3. So the maximum points
## we get is 6.
#
## Example 2
##
## Input: @int = (1, 1, 2, 2, 2, 3)
## Output: 11
##
## First we delete 2 and that would also delete both the 1's and the 3. Now we
## have (2, 2).
## Then we delete another 2 and followed by the third deletion of 2. So the
## maximum points we get is 11.
#
############################################################
##
## discussion
##
############################################################
#
# We can check each element from the list as the "kill" integer.
# For that integer, we calculate the points.
# Then we output the maximum points.

use strict;
use warnings;
use List::Util qw(max);

kill_and_win(2, 3, 1);
kill_and_win(1, 1, 2, 2, 2, 3);
kill_and_win(1, 2, 3, 4, 8, 4, 3);

sub kill_and_win {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   my $results;
   foreach my $elem (@list) {
      next if $results->{$elem}; # no need to recalculate duplicates
      # calculate the sum for the deleted elements of the list if we
      # kill $elem
      my $result = kill_from_list($elem, @list);
      $results->{$elem} = $result;
   }
   print "Output: " . max(values(%$results)) . "\n";
}

sub kill_from_list {
   my ($what, @list) = @_;
   my $sum = 0;
   foreach my $elem (@list) {
      $sum += $elem if $elem == $what;
      $sum += $elem if $elem == $what + 1;
      $sum += $elem if $elem == $what - 1;
   }
   return $sum;
}
