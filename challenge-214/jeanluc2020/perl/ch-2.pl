#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-214/#TASK2
#
# Task 2: Collect Points
# ======================
#
# You are given a list of numbers.
#
# You will perform a series of removal operations. For each operation, you
# remove from the list N (one or more) equal and consecutive numbers, and add
# to your score N × N.
#
# Determine the maximum possible score.
#
## Example 1:
##
## Input: @numbers = (2,4,3,3,3,4,5,4,2)
## Output: 23
##
## We see three 3's next to each other so let us remove that first and collect 3 x 3 points.
## So now the list is (2,4,4,5,4,2).
## Let us now remove 5 so that all 4's can be next to each other and collect 1 x 1 point.
## So now the list is (2,4,4,4,2).
## Time to remove three 4's and collect 3 x 3 points.
## Now the list is (2,2).
## Finally remove both 2's and collect 2 x 2 points.
## So the total points collected is 9 + 1 + 9 + 4 => 23.
#
## Example 2:
##
## Input: @numbers = (1,2,2,2,2,1)
## Output: 20
##
## Remove four 2's first and collect 4 x 4 points.
## Now the list is (1,1).
## Finally remove the two 1's and collect 2 x 2 points.
## So the total points collected is 16 + 4 => 20.
#
## Example 3:
##
## Input: @numbers = (1)
## Output: 1
#
## Example 4:
##
## Input: @numbers = (2,2,2,1,1,2,2,2)
## Output: 40
##
## Remove two 1's = 2 x 2 points.
## Now the list is (2,2,2,2,2,2).
## Then reomove six 2's = 6 x 6 points.
#
############################################################
##
## discussion
##
############################################################
#
# We calculate the maximum by trying to remove consecutive
# same numbers from every position in the array, calculating
# the maximum points we can get with the remaining numbers
# and adding it to the points we generated in this first step.

use strict;
use warnings;
use Data::Dumper;

collect_points(2,4,3,3,3,4,5,4,2);
collect_points(1,2,2,2,2,1);
collect_points(1);
collect_points(2,2,2,1,1,2,2,2);

sub collect_points {
   my @numbers = @_;
   print "Input: (" . join(",", @numbers) . ")\n";
   print "Output: " . maximum_possible(@numbers) . "\n";
}

sub maximum_possible {
   my @numbers = @_;
   return 0 unless @numbers;
   my $max = 0;
   foreach my $i (0..$#numbers) {
      # how many points (and which rest) do we get if we remove
      # consecutive same numbers starting at position i?
      my ($points, @rest) = remove_consecutive($i, @numbers);
      my $this = $points + maximum_possible(@rest);
      $max = $this if $this > $max;
   }
   return $max;
}

sub remove_consecutive {
   my ($index, @numbers) = @_;
   return (0) unless @numbers;
   my $points = 0;
   my @rest = ();
   if($index > 0) {
      if($numbers[$index-1] == $numbers[$index]) {
         # we've been here already in a previous call,
         # so we can exit now
         return (0);
      }
   }
   # currently, we haven't removed anything
   my $count = 0;
   # just keep the rest up to the current index
   @rest = @numbers[0..$index-1];
   # find the last index that has the same number as the
   # one at $index
   my $last_index = $index;
   foreach my $i ($index..$#numbers) {
      last if $numbers[$i] != $numbers[$index];
      $count++;
      $last_index = $i;
   }
   # how many points did we get?
   $points = $count * $count;
   # keep the remaining rest of the array.
   push @rest, @numbers[$last_index+1..$#numbers];
   return($points, @rest);
}
