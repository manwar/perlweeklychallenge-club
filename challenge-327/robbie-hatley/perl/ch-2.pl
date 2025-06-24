#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 327-2,
written by Robbie Hatley on Mon Jun 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 327-2: Minimum Absolute Difference
Submitted by: Mohammad Sajid Anwar
You are given an array of distinct integers. Write a script to
find all pairs of elements with minimum absolute difference
of any two elements.

Example 1
Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

Example 2
Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]

Example 3
Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I solve this by first sorting the array, then hashing all pairs by absolute value of difference. I determine
minimum absolute value of difference by applying function "min" from CPAN module "List::Util" to the keys of
the hash. Then I return those pairs corresponding to that hash key.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of unique integers, in proper Perl syntax, like so:

./ch-2.pl '([5,8,13,-42,-6],[-137,4,18,44,66])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8::all;
   use List::Util 'min';

   # Is a given scalar a reference to an array of unique integers?
   sub is_array_of_unique_ints ($aref) {
      return 0 if 'ARRAY' ne ref $aref;
      for (@$aref) {return 0 if $_ !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/}
      for    ( my $i =    0   ; $i <= $#$aref-1 ; ++$i ) {
         for ( my $j = $i + 1 ; $j <= $#$aref-0 ; ++$j ) {
            return 0 if $$aref[$i] == $$aref[$j]}}
      return 1}

   # Return all pairs of integers from given array for which
   # the absolute value of their difference is minimum:
   sub min_abs_diff_pairs ($aref) {
      my @srt = sort {$a<=>$b} @$aref;
      my %pairs;
      # Hash all pairs by absolute difference:
      for    ( my $i =    0   ; $i <= $#srt-1 ; ++$i ) {
         for ( my $j = $i + 1 ; $j <= $#srt-0 ; ++$j ) {
            my $adiff = abs($srt[$i]-$srt[$j]);
            push @{$pairs{$adiff}}, [$srt[$i], $srt[$j]]}}
      # Return pairs with minimum absolute difference:
      return @{$pairs{min keys %pairs}}}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (     [4, 1, 2, 3],       [1, 3, 7, 11, 15],   [1, 5, 3, 8]   );
#                  Expected outputs :   ([1,2], [2,3], [3,4]),       ([1,3]),       ([1,3], [3,5])

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   if (!is_array_of_unique_ints($aref)) {
      say "Error: Not an array of unique integers.";
      next;
   }
   my @MADP = min_abs_diff_pairs($aref);
   my @MADP_strs = map { '[' . $_->[0] . ', ' . $_->[1] . ']' } @MADP;
   say "Pairs with minimum absolute difference = (@MADP_strs)";
}
