#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 396-2,
written by Robbie Hatley on Thu Oct 22, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 396-2: Trionic Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to return
true if the given array is Trionic otherwise return false.
An array is trionic if there exist indices 0 < p < q < n−1
such that arr[0..p] is strictly increasing, arr[p..q] is
strictly decreasing, and arr[q..n−1] is strictly increasing.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

To solve this problem, I'll simply keep a list of changes of direction. That list should be 'UDU'. If it's
anything else, the array is not trionic.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated list of 4-or-more integers. For example, the first two
arguments here are invalid, but next two are valid:

./ch-2.pl 'cow,pig,horse,cat' '1,2,3' '1,3,9,2,7,4' '1,3,9,7,-6,8,17'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   $"=', ';

   # What are the direction changes of an integer array?
   sub changes ( $aref ) {
      # Keep track of changes:
      my $chs = '';
      # Initial direction is unknown, so set it to 'X':
      my $dir = 'X';
      # Record all changes of direction:
      for my $idx (1..$#$aref) {
         my $curdir;
         # Are we going down?
         if    ( $aref->[$idx] <  $aref->[$idx-1] ) {
            $curdir = 'D';
         }
         # Are we going sideways?
         elsif ( $aref->[$idx] == $aref->[$idx-1] ) {
            $curdir = 'S';
         }
         # Are we going up?
         else {
            $curdir = 'U';
         }
         # Did we change direction?
         if ($curdir ne $dir) {
            $dir  = $curdir;
            $chs .= $curdir;
         }
      }
      $chs;
   }

   # Is a given input valid?
   sub is_valid ( $aref ) {
      return false if 'ARRAY' ne reftype($aref);
      my @a = @$aref;
      return false if scalar(@a) < 4;
      for ( @a ) {
         return false if $_ !~ m/^0$|^-?[1-9]\d*$/;
      }
      return true;
   }

   # Parse comma-separated lists of items:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   [1,  3, 5, 4, 2, 6, 8   ], # true
   [1,  4, 4, 2, 1, 3, 5   ], # false
   [2, 10, 3, 1, 9         ], # true
   [1,  2, 3, 4, 3, 2, 1   ], # false
   [1,  3, 6, 4, 2, 7, 8, 4], # false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Array: (@$aref)";
   if (!is_valid($aref)) {
      warn "Error: Argument must be a comma-separated list of 4-or-more integers.\n";
      next;
   }
   my $chs = changes($aref);
   say "Changes of direction = $chs";
   my $trionic = 'UDU' eq $chs ? 'True.' : 'False.';
   say "Trionic? $trionic";
}
