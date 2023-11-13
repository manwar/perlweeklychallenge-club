#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/#TASK1
#
# Task 1: Missing Members
# =======================
#
# You are given two arrays of integers.
#
# Write a script to find out the missing members in each other arrays.
#
## Example 1
##
## Input: @arr1 = (1, 2, 3)
##        @arr2 = (2, 4, 6)
## Output: ([1, 3], [4, 6])
##
## (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
## (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
#
## Example 2
##
## Input: @arr1 = (1, 2, 3, 3)
##        @arr2 = (1, 1, 2, 2)
## Output: ([3])
##
## (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
## (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
#
############################################################
##
## discussion
##
############################################################
#
# For each element of each array, if it is not in the other array,
# save it for the output.
# Example 2 has a caveat though, by not returning an empty array in
# case of no missing elements it is unclear in which of the arrays
# the element was originally. It's better to return an empty array
# here, so let's just do that instead.

missing_members( [ 1, 2, 3 ], [ 2, 4, 6 ] );
missing_members( [ 1, 2, 3, 3 ], [ 1, 1, 2, 2 ] );

sub missing_members {
   my ($arr1, $arr2) = @_;
   print "Input: (" . join(", ", @$arr1) . "), (" . join(", ", @$arr2) . ")\n";
   my (@res1, @res2, %keys1, %keys2);
   map { $keys1{$_} = 1; } @$arr1;
   map { $keys2{$_} = 1; } @$arr2;
   my %seen = ();
   foreach my $elem (@$arr1) {
      push @res1, $elem unless $keys2{$elem} or $seen{$elem};
      $seen{$elem} = 1;
   }
   %seen = ();
   foreach my $elem (@$arr2) {
      push @res2, $elem unless $keys1{$elem} or $seen{$elem};
      $seen{$elem} = 1;
   }
   print "Output: ([" . join(", ", @res1) . "], [" . join(", ", @res2) . "])\n";
}
