#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-198/#TASK1
#
# You are given a list of integers, @list.
#
# Write a script to find the total pairs in the sorted list where 2 consecutive
# elements has the max gap. If the list contains less then 2 elements then
# return 0.
#
## Example 1
##
## Input:  @list = (2,5,8,1)
## Output: 2
##
## Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
#
## Example 2
##
## Input: @list = (3)
## Output: 0
#
### This is a pretty straightforward problem. Let's just walk the array,
### calculate the gap of 2 consecutive values, remember this instance, and in
### the end display the value for the maximum of the gaps

use strict;
use warnings;
use feature 'say';
use List::Util qw(max);

# some examples of lists
my $lists = [
   [ 2, 5, 8, 1 ],
   [ 3 ],
   [ 1, 2, 3, 5, 7, 9, 13, 17],
   [ 1, 3, 7, 4, 9, 11 ]
];

# let's generate the output for all examples
foreach my $list ( @$lists ) {
   say "(" . join(", ", @$list) . ") returns " . max_gap(@$list);
}

# let's calculate the gaps
sub max_gap {
   my @list = sort { $a <=> $b } @_;
   my $gaps;
   # if the list contains less than 2 elements then return 0
   return 0 if scalar(@list) < 2;
   my $last = undef;
   foreach my $elem (@list) {
      if(defined($last)) {
         # we're at least at the second element, so let's calculate the gap
         # to the previous element and count this instance
         $gaps->{ $elem - $last }++;
      }
      $last = $elem;
   }
   # return the number of instances for the max gap
   return $gaps->{ max(keys %$gaps) };
}

