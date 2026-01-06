#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 355-2,
written by Robbie Hatley on Mon Jan 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 355-2: Mountain Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
return true if the given array is a valid mountain array.
An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example #1:
Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example #2:
Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true

Example #3:
Input: @ints = (5, 4, 3, 2, 1)
Output: false

Example #4:
Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false

Example #5:
Input: @ints = (1, 3, 2)
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll make these four subroutines:

   # Return the index of the first greatest element of a list:
   sub peak_idx ( @list ) {...}

   # Return 1 iff a list is strictly increasing, else return 0:
   sub is_strictly_increasing ( @list ) {...}

   # Return 1 iff a list is strictly decreasing, else return 0:
   sub is_strictly_decreasing ( @list ) {...}

   # Return 'True.' iff a list is "mountainous", else return 'False.':
   sub is_mountain ( @list ) {...}

That should be sufficient to crack the problem wide open.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:

./ch-2.pl '([8,9,7,3,4],[4,6,8,24,22,20])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return the index of the first greatest element of a list:
   sub peak_idx ( @list ) {
      my $pv = $list[0];  # peak value
      my $pi = 0;         # peak index
      foreach my $idx (1..$#list) {
         my $cv = $list[$idx]; # current value
         if ($list[$idx] > $pv) {$pv = $cv;$pi = $idx}}
      return $pi}

   # Return 1 iff a list is strictly increasing, else return 0:
   sub is_strictly_increasing ( @list ) {
      foreach my $idx (1..$#list) {
         return 0 if $list[$idx] <= $list[$idx-1]}
      return 1}

   # Return 1 iff a list is strictly decreasing, else return 0:
   sub is_strictly_decreasing ( @list ) {
      foreach my $idx (1..$#list) {
         return 0 if $list[$idx] >= $list[$idx-1]}
      return 1}

   # Return 1 iff a list is "mountainous", else return 0:
   sub is_mountain ( @list ) {
      my $pi = peak_idx(@list);
      return 0 if $pi < 1 || $pi > $#list-1;
      return 0 if !is_strictly_increasing(@list[0..$pi]);
      return 0 if !is_strictly_decreasing(@list[$pi..$#list]);
      return 1}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 2, 3, 4, 5],       # Expect: 'False.'
   [0, 2, 4, 6, 4, 2, 0], # Expect: 'True.'
   [5, 4, 3, 2, 1],       # Expect: 'False.'
   [1, 3, 5, 5, 4, 2],    # Expect: 'False.'
   [1, 3, 2],             # Expect: 'True.'
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $im = is_mountain(@$aref);
   say 'Is mountain? ', $im?'True.':'False';
}
