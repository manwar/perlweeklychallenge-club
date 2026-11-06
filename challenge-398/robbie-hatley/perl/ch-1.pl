#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 398-1,
written by Robbie Hatley on Tue Nov 03, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 398-1: Divisible Average
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers. Write a script to
return the closest integer to the mean value of all even integers
that are divisible by 3. If none is divisible, return 0.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

The phrase "even integers that are divisible by 3" is the same as "integers which are divisible by 6", so I
need only test "0 == $int % 6", and if there are some of those, return "floor(mean(@ints)+0.5)", else 0.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated sequence of positive integers. For example:

./ch-1.pl '1,2,3,4,5' '1,2,3,4,5,6' '12,38,48,24,17,57'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use utf8::all;
   use List::Util 'sum0';
   $"=', ';

   # Closest int to mean of divisible-by-6 ints:
   sub int_mean_div_6 ( $aref ) {
      my @div = ();
      for (@$aref) {
         if (0 == $_ % 6) {
            push @div, $_;
         }
      }
      my $mean = 0;
      if (@div) {
         $mean = sum0(@div)/scalar(@div);
      }
      return floor($mean + 0.5);
   }

   # Parse lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

   # Is a given scalar a reference to an array of 1-or-more positive integers?
   sub valid ( $aref ) {
      return false unless 'ARRAY' eq reftype $aref;
      return false unless 0 < scalar @$aref;
      foreach my $s (@$aref) {
         return false unless $s =~ m/^[1-9]\d*$/;
      }
      return true;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   [18, 5, 7, 11],            # 18
   [6, 12, 18, 24, 30, 40],   # 18
   [3, 9, 15, 21, 27],        #  0
   [6, 12, 14, 20],           #  9
   [6, 6, 6, 12, 12],         #  8
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   if (!valid($aref)) {
      warn "Error: Input must be a comma-separated list of positive integers.\n";
      next;
   }
   say "Ints = (@$aref)";
   my $imd6 = int_mean_div_6($aref);
   say "Nearest int to mean of divisible-by-6 elements = $imd6";
}
