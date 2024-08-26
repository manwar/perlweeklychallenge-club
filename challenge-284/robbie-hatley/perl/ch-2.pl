#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 284-2,
written by Robbie Hatley on Sun Aug 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 284-2: Relative Sort
Submitted by: Mohammad Sajid Anwar
You are given two list of integers, @list1 and @list2.
The elements in the @list2 are distinct and also in @list1.
Write a script to sort the elements in @list1 such that the
relative order of items in @list1 is same as in the @list2.
Elements of @list1 which are not in @list2 should be placed
at the end of @list1 in ascending order.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

First, I'll need subs to perform these 3 checks:

1. Does an array consist purely of integers?
2. Does an array consist purely of unique elements?
3. Is one array a subset of another?

Then apply those subs to @list1 and @list2 to make sure that both lists are integers-only, @list2 is unique,
and @list2 is a subset of @list1.

Then, I'll need to write a sub that creates a @list3 starting with same-value clusters of elements of @list1
which are also in @list2, in the same numeric-value order as the elements of @list2, followed by the orphans
from @list1 which aren't in @list2 sorted in increasing numeric order. I'll do this as follows: for each
element $e2 of @list2, splice each element $e1 of @list1 which is equal to $e2 from @list1 and push it to
@list3. Then sort the remaining elements of @list1 by acending numeric order and push them to @list3.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([[-17,5,3,82,1,4,17],[5,4,3]],[[-17,5,3,82,1,4,17],[3,4,5]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;

# Does an array consist only of decimal representations of integers?
sub is_ints :prototype(\@) ($aref) {
   foreach my $item (@$aref) {
      $item !~ m/^-[1-9][0-9]*$|^0$|^[1-9][0-9]*$/ and return 0
   }
   return 1
}

# Does an array consist only of unique elements?
sub is_unique :prototype(\@) ($aref) {
   my %abundance;
   foreach my $item (@$aref) {
      ++$abundance{$item}
   }
   foreach my $key (keys %abundance) {
      1 != $abundance{$key} and return 0
   }
   return 1
}

# Is array A a subset of array B?
sub is_subset :prototype(\@\@) ($Aref, $Bref) {
   A: foreach my $A (@$Aref) {
      B: foreach my $B (@$Bref) {
         next A if $A == $B;
      }
      return 0
   }
   return 1
}

# Make a @list3 consisting of elements of @list1 which are also in @list2 sorted relative to @list2,
# with remainder, sorted, tacked to end, and return @list3 to caller:
sub relative_sort :prototype(\@\@) ($list1ref, $list2ref) {
   my @list1 = @$list1ref;
   my @list2 = @$list2ref;
   my @list3 = ();
   # First, splice-out elements of @list1 which are in @list2 and push them to @list3:
   for my $e2 (@list2) {
      for ( my $idx1 = 0 ; $idx1 <= $#list1 ; ++$idx1 ) {
         my $e1 = $list1[$idx1];
         if ($e1 == $e2) {
            push @list3, splice @list1, $idx1, 1;
            --$idx1 # Must re-visit same index because it now has new contents.
         }
      }
   }
   # Then, sort the orphans and tack them to the end of @list3:
   push @list3, sort {$a<=>$b} @list1;
   # Finally, return result to caller:
   return @list3;
}

# ------------------------------------------------------------------------------------------------------------
# EXAMPLE INPUTS AND EXPECTED OUTPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [
      [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
      [2, 1, 4, 3, 5, 6],
   ],
   # Expected ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

   [
      [3, 3, 4, 6, 2, 4, 2, 1, 3],
      [1, 3, 2]
   ],
   # Expected output: (1, 3, 3, 3, 2, 2, 4, 4, 6)

   [
      [3, 0, 5, 0, 2, 1, 4, 1, 1],
      [1, 0, 3, 2],
   ],
   # Expected output: (1, 1, 1, 0, 0, 3, 2, 4, 5)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @list1 = @{$$aref[0]};
   my @list2 = @{$$aref[1]};
   say "List 1: (@list1)";
   say "List 2: (@list2)";

   !is_ints   @list1 and say "Error: \@list1 not array of integers. \nMoving on to next array pair." and next;
   !is_ints   @list2 and say "Error: \@list2 not array of integers. \nMoving on to next array pair." and next;
   !is_unique @list2 and say "Error: \@list2 is not unique elements.\nMoving on to next array pair." and next;
   !is_subset @list2, @list1
                     and say "Error: \@list2 not subset of \@list1.  \nMoving on to next array pair." and next;

   my @list3 = relative_sort @list1, @list2;
   say "List 1 sorted relative to List 2: (@list3)";
}
