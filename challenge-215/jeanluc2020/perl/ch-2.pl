#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-215/#TASK2
#
# Task 2: Number Placement
# ========================
#
# You are given a list of numbers having just 0 and 1. You are also
# given placement count (>=1).
#
# Write a script to find out if it is possible to replace 0 with 1
# in the given list. The only condition is that you can only replace
# when there is no 1 on either side. Print 1 if it is possible
# otherwise 0.
#
## Example 1:
##
## Input: @numbers = (1,0,0,0,1), $count = 1
## Output: 1
##
## You are asked to replace only one 0 as given count is 1.
## We can easily replace middle 0 in the list i.e. (1,0,1,0,1).
#
## Example 2:
##
## Input: @numbers = (1,0,0,0,1), $count = 2
## Output: 0
##
## You are asked to replace two 0's as given count is 2.
## It is impossible to replace two 0's.
#
## Example 3:
##
## Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# So, if we can replace $count 0's with 1's, we should print 1,
# otherwise 0. number_placement() will do that, calling the
# can_replace() function to check the possibility.
# can_replace() replaces one 0 with a 1 via the replace() function,
# and if that worked, calls itself recursively with the new array
# and $count - 1.
# replace() short-circuits its execution by replacing the first
# possible 0 that can be replaced and then returning the resulting
# new array, leaving everything else for the recursive calls of the
# can_replace() function and subsequent replace() calls

use strict;
use warnings;

number_placement( [1,0,0,0,1], 1);
number_placement( [1,0,0,0,1], 2);
number_placement( [1,0,0,0,0,0,0,0,1], 3);

sub number_placement {
   my ($numbers, $count) = @_;
   print "Input: (" . join(",", @$numbers), "), $count\n";
   die "Illegal count" unless $count > 0;
   print "Output: ";
   if(can_replace($numbers, $count)) {
      print "1\n";
   } else {
      print "0\n";
   }
}

sub can_replace {
   my ($numbers, $count) = @_;
   return 1 unless $count; # nothing left to do, all replacements done
   my $new_numbers = replace($numbers);
   if($new_numbers) {
      return can_replace($new_numbers, $count - 1);
   }
   return 0;
}

# replace one 0 with a 1 in the given array.
# We do this by finding the first 0 that we can
# replace. Once that is replaced, we return the
# new array with the replacement in place. If we
# can't replace a 0 with a 1, we return undef
# to signal this fact
sub replace {
   my $numbers = shift;
   my $new_numbers = [ @$numbers ];
   my $last_idx = scalar(@$numbers) - 1;
   foreach my $i (0..$last_idx) {
      my $can_replace = 0;
      if($numbers->[$i] == 0) {
         $can_replace = 1;
         if($i > 0) {
            if($numbers->[$i-1] == 0) {
               $can_replace = 1;
            } else {
               $can_replace = 0;
            }
         }
         if($i < $last_idx && $can_replace) {
            if($numbers->[$i+1] == 0) {
               $can_replace = 1;
            } else {
               $can_replace = 0;
            }
         }
         if($can_replace) {
            $new_numbers->[$i] = 1;
            return $new_numbers;
         }
      }
   }
   return undef;
}
