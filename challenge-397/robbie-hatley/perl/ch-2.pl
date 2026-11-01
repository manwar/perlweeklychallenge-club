#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 397-2,
written by Robbie Hatley on Sat Oct 31, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 397-2: Binary Reflection
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to sort the
given array in ascending order based on the binary reflection of
each element. If two different numbers have the same binary
reflection, the smaller original number should appear first.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I use two subs: "br" (which returns the binary reflection of an integer), and "reflection_sort" (which sorts
integers firstly by binary reflection, and secondly by value).

Also note that the problem description is flawed, because "binary reflection" is not uniquely defined for
negative integers, because the number of "1" bits used depends on the size (in bits) of integer type being
used, so it would be different for 8-bit, 16-bit, 32-bit, and 64-bit integers. And Perl doesn't make it easy
to determine what it's using under-the-hood to represent negative integers. Therefore I restrict this program
to non-negative integers only.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated list of integers. For example:

./ch-2.pl '47,28,8,2,0,9,14' '3,8,37,4,26,10,11'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   $"=', ';

   # What is the binary reflection of an integer?
   sub br ( $x ) {
      oct('0b'.reverse(sprintf("%b",$x)));
   }

   # Sort non-negative integers by binary reflection:
   sub reflection_sort ( $aref ) {
      my %hash;
      $hash{$_} = br($_) for (@$aref);
      sort {$hash{$a}<=>$hash{$b}||$a<=>$b} @$aref;
   }

   # Parse lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

   # Is a given scalar a ref to an array of 1-or-more non-negative ints?
   sub valid ( $aref ) {
      return false unless 'ARRAY' eq reftype $aref;
      return false unless 0 < scalar @$aref;
      foreach my $s (@$aref) {
         return false unless $s =~ m/^0$|^[1-9]\d*$/;
      }
      return true;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   [ 3, 6, 12       ] , # (3, 6, 12)
   [ 1, 2, 4, 8     ] , # (1, 2, 4, 8)
   [ 7, 8, 9, 10    ] , # (8, 10, 7, 9)
   [ 5, 9, 15, 17   ] , # (5, 9, 15, 17)
   [ 11, 13, 14, 19 ] , # (14, 13, 11, 19)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Integers = (@$aref)";
   if ( !valid($aref) ) {
      warn "Error: Input must be an array of 1-or-more non-negative integers.\n";
      next;
   }
   my @rs = reflection_sort($aref);
   say "Integers sorted by reflection = (@rs)";
}
