#!/usr/bin/perl
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-201/#TASK2
#
# You are given an integer, $n > 0.
#
# Write a script to determine the number of ways of putting $n pennies in a row of piles of ascending heights from left to right.
#
## Example
##
## Input: $n = 5
## Output: 7
##
## Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
##
##     1 1 1 1 1
##     1 1 1 2
##     1 2 2
##     1 1 3
##     2 3
##     1 4
##     5
#
######################################################################
##
## discussion
##
######################################################################
#
# we can find all ways of stacking $n pennies by creating the right-most
# pile first, going from 1..$n
# then we create all solutions for the remaining pennies but with the constraint
# that the biggest pile can only be as big as the one we already built. To each
# of all these solutions we add our right-most pile and return them.
#

use strict;
use warnings;
use feature 'say';

my @examples = (1, 2, 3, 4, 5, 10, 20);

foreach my $example (@examples) {
   my @solutions = find_solutions($example);
   say scalar(@solutions) . " solutions found:";
   foreach my $solution (@solutions) {
      say join(" ", @$solution);
   }
}

# our recursive function
sub find_solutions {
   my ($n, $max_pile_size) = @_;
   # if no maximum pile size was given use $n as fallback
   $max_pile_size //= $n;
   # limit $max_pile_size to $n
   $max_pile_size = $n if $max_pile_size > $n;
   my @solutions;
   # There is only an empty solution if $n is 0
   return ([]) unless $n > 0;
   # now create the last pile
   foreach my $last (1..$max_pile_size) {
      # create all piles left to the last one
      my @sub_solutions = find_solutions($n - $last, $last);
      # add the last pile to each of these solutions and add
      # the solutions to our return array
      foreach my $sub_solution (@sub_solutions) {
         push @$sub_solution, $last;
         push @solutions, $sub_solution;
      }
   }
   return @solutions;
}
