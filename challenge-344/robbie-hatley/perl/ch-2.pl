#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 344-2,
written by Robbie Hatley on Sat Oct 25, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 344-2: Array Formation
Submitted by: Mohammad Sajid Anwar
You are given two lists: @source and @target. Write a script to
see if you can build the exact @target by putting these smaller
lists from @source together in some order. You cannot break apart
or change the order inside any of the smaller lists in @source.

Example 1
Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true
Use in the order: [1], [2,3], [4]

Example 2
Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3
Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true
Use in the order: [5,8], [2], [9,1]

Example 4
Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false
Missing number: 2

Example 5
Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true
Use in the order: [7, 4, 6]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a recursive approach. I'll first try to match each source sub-array to the first few digits of the
target. If no match, move to next source sub-array. If source sub-array matches target exactly, return 'true'.
If partial match, send unmatched portions of source and target to next recursive level, and if the recursive
call returns 'true', return 'true'. If no recursive call matches, return 'false'.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of arrays of digits, in proper Perl syntax, like so:

./ch-2.pl '([[[1,7],[6,3]], [6,1,7,3]], [[[1,7],[6,3]], [6,3,1,7]])'

Of each inner array, the first element will be the "source" described in the problem description, and the
second element will be the "target".

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Are two arrays equal?
   sub is_equal ($aref1, $aref2) {
      my $m = scalar @$aref1;
      my $n = scalar @$aref2;
      if ($m != $n) {return 0}
      for (0..$n-1) {if ($$aref1[$_] != $$aref2[$_]) {return 0}}
      return 1}

   # Can a target be built from a source?
   sub can_build ($aref1, $aref2) {
      my @src = @$aref1;         # Array  of source arrays.
      my $ssz = scalar(@src);    # Number of source arrays.
      my @tar = @$aref2;         # Target array.
      my $tsz = scalar(@tar);    # Target size.
      for my $idx (0..$ssz-1) {
         my @sa = @{$src[$idx]}; # Source array.
         my $sas = scalar(@sa);  # Size of source array.
         # Skip @sa if it's bigger than @tar:
         next if ($sas > $tsz);
         # Get the first $sas elements of @tar:
         my @prefix = @tar[0..$sas-1];
         # Skip to next source array if @sa doesn't match @prefix:
         next if (!is_equal(\@sa,\@prefix));
         # If we get to here, sub-array matches beginning of target.
         # If this is a total match, return 'true':
         return 'true' if $sas == $tsz;
         # If we get to here, it's a partial match. Call this function again,
         # recursively, and send it the unused portions of @src and @trg:
         my @psrc = (@src[0..$idx-1], @src[$idx+1..$ssz-1]);
         my @ptrg = (@tar[$sas..$tsz-1]);
         my $result = can_build(\@psrc,\@ptrg);
         # If that recursive function call returned 'true', return 'true':
         return 'true' if 'true' eq $result}
      # If we get to here, no way exists to build @src from @tar,
      # so return 'false':
      return 'false'}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [[[2,3], [1], [4]], [1, 2, 3, 4]],
   # Expected output: true

   # Example 2 input:
   [[[1,3], [2,4]], [1, 2, 3, 4]],
   # Expected output: false

   # Example 3 input:
   [[[9,1], [5,8], [2]], [5, 8, 2, 9, 1]],
   # Expected output: true

   # Example 4 input:
   [[[1], [3]], [1, 2, 3]],
   # Expected output: false

   # Example 5 input:
   [[[7,4,6]], [7, 4, 6]],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $aref1 = $aref->[0];
   my $aref2 = $aref->[1];
   say 'Source arrays: ', join(', ', map {'['."@$_".']'} @$aref1);
   say "Target array:  (@$aref2)";
   my $cb = can_build($aref1, $aref2);
   say "Can build? $cb";
}
