#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 373-2,
written by Robbie Hatley on Sun May 17, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 373-2: List Division
Submitted by: Mark Anderson
You are given a list and a non-negative integer. Write a script
to divide the given list into given non-negative integer equal
parts. Return -1 if the integer is more than the size of the
list.

Examples: See "my @arrays =" section below.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The description allows a number-of-list of 0, yet this is impossible, hence I'll return -1 if the input
integer is either < 1 or > n (where n is the size of the list). To get the odd clusterings show in the
examples, I'll have to abandon the idea of using modular arithmetic and use a method of "quotients and
remainders" instead. (Would make more sense to me to treat this as a poker deal, not a cake cut; but that's
how this problem is structured.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array containing of an array followed by a non-negative
integer, in proper Perl syntax, like so:

./ch-2.pl '([["rat", "bat", "cat"], 2], [[5,8,7,4,9,2], 3])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Split a list:
   sub split_list ( $lref , $m ) {
      my @list = @{$lref};
      my $n = scalar @list;
      return -1 if $m < 1 || $m > $n;
      my $q = int($n/$m);
      my $r = $n - $q*$m;
      my @arrays;
      for my $i (0..$m-1) { # For each sub-list:
         my $l = $q;        # Length of this sub-list.
         if ( $r > 0 ) {    # But if there's a remainder,
            ++$l;           # increment length
            --$r;           # and decrement remainder.
         }
         my @part = splice(@list, 0, $l);
         push @arrays, \@part;
      }
      return @arrays;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [[1,2,3,4,5], 2],
   # Expected output: [[1,2,3], [4,5]]

   # Example #2 input:
   [[1,2,3,4,5,6], 3],
   # Expected output: [[1,2], [3,4], [5,6]]

   # Example #3 input:
   [[1,2,3], 2],
   # Expected output: [[1,2], [3]]

   # Example #4 input:
   [[1,2,3,4,5,6,7,8,9,10], 5],
   # Expected output: [[1,2], [3,4], [5,6], [7,8], [9,10]]

   # Example #5 input:
   [[1,2,3], 4],
   # Expected output: -1

   # Example #6 input:
   [[72,57,89,55,36,84,10,95,99,35], 7]
   # Expected output: [[72,57], [89,55], [36,84], [10], [95], [99], [35]]
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $lref = $aref->[0];
   my $m    = $aref->[1];
   say "List = (@$lref). Number of parts = $m.";
   my @parts = split_list($lref , $m);
   say 'Parts:';
   if ( 1 == scalar(@parts) && -1 == $parts[0] ) {
      say 'None.';
   }
   else {
      for my $part ( @parts ) {
         say "[@{$part}]";
      }
   }
}
