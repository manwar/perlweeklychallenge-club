#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 318-2,
written by Robbie Hatley on Wed Apr 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 318-2: Reverse Equals
Submitted by: Roger Bell_West
You are given two arrays of integers, each containing the same
elements as the other. Write a script to return true if one array
can be made to equal the other by reversing exactly one
contiguous subarray.

Example #1:
Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true
Reverse elements: 0-2

Example #2:
Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false

Example #3:
Input: @source = (2)
       @target = (2)
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The only approach I can see is to laboriously reverse each subarray of array 1 and see if the altered array 1
now equals array 2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of integers, in proper Perl syntax. Each inner pair of arrays
should have the same elements (though possibly in different orders). For example:

./ch-2.pl '([[2,4,8,6,10,12],[2,4,6,8,10,12]],[[1,8,3,6,5,7,4,2],[1,2,3,4,5,6,7,8]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Do two arrays of integers have the same elements?
   sub same_elements ($aref1, $aref2) {
      return 0 if 'ARRAY' ne ref $aref1;
      return 0 if 'ARRAY' ne ref $aref2;
      my $m = scalar @$aref1;
      my $n = scalar @$aref2;
      return 0 if $m != $n;
      return 1 if 0 == $m && 0 == $n;
      my @sorted1 = sort {$a<=>$b}  @$aref1;
      my @sorted2 = sort {$a<=>$b}  @$aref2;
      for (0..$m-1){
         return 0 if $sorted1[$_] != $sorted2[$_];
      }
      return 1;
   }

   # Are two arrays of integers equal?
   sub are_equal ($aref1, $aref2) {
      return 0 if 'ARRAY' ne ref $aref1;
      return 0 if 'ARRAY' ne ref $aref2;
      my $m = scalar @$aref1;
      my $n = scalar @$aref2;
      return 0 if $m != $n;
      return 1 if 0 == $m && 0 == $n;
      for (0..$m-1){
         return 0 if $$aref1[$_] != $$aref2[$_];
      }
      return 1;
   }

   # Can one array of integers be made equal to another by
   # reversing exactly 1 contiguous subarray?
   sub reverse_equals ($aref1, $aref2) {
      # For "equality through reversal" to be possible,
      # the two arrays must have the same elements:
      return 'False.' unless same_elements($aref1, $aref2);
      # For two identical arrays, the target can be made from
      # the source by reversing any length 0 or 1 subarray:
      return 'True.' if are_equal($aref1, $aref2);
      # Now look at each reversible subarray of @$aref1;
      # if we reverse it, will @$aref1 be equal to @$aref2?
      my $m = scalar(@$aref1);
      for    ( my $i = 0 ; $i <= $m-2  ; ++$i ) {
         for ( my $s = 2 ; $s <= $m-$i ; ++$s ) {
            my @altered;
            push @altered, @$aref1[0..$i-1];
            push @altered, @$aref1[reverse $i..$i+$s-1];
            push @altered, @$aref1[$i+$s..$m-1];
            if (are_equal(\@altered,$aref2)) {return 'True.'}
         }
      }
      return 'False.';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Inputs for Example #1:
   [
      [3, 2, 1, 4],
      [1, 2, 3, 4],
   ],
   # Expected output: true

   # Inputs for Example #2:
   [
      [1, 3, 4],
      [4, 1, 3],
   ],
   # Expected output: false

   # Inputs for Example #3:
   [
      [2],
      [2],
   ],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Source array = (@{$$aref[0]})";
   say "Target array = (@{$$aref[1]})";
   my $answer = reverse_equals($$aref[0], $$aref[1]);
   say "Can make target from source by reversing 1 subarray? $answer";
}
