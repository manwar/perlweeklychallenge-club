#! /usr/bin/perl

# Robbie Hatley's Perl solution to challenge 197-2

=pod

Task 2:
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.
Write a script to perform a Wiggle Sort on the given list.
(A "Wiggle Sort" would be such as list[0] < list[1] > list[2] < list[3]....)

Example 1:  Input: (1,5,1,1,6,4)  Output: (1,6,1,5,1,4)
Example 2:  Input: (1,3,2,2,3,1)  Output: (2,3,1,3,1,2)

WARNING: This is not the usual way of defining "Wiggle Sort", which
         normally uses "<=" and ">=" instead of "<" and ">".
         Let's call this version "Strong Wiggle Sort".

WARNING: Not all inputs are CAPABLE of being Strong-Wiggle-Sorted.

WARNING: Both Weak and Strong Wiggle Sort are non-deterministic,
         so there are often multiple valid wiggle-sortings of an array.

=cut

# NOTE: Input is from built-in array or command-line args.
#       If using args, they should be space-separated integers.

# NOTE: Output is to stdout and will be a printout of each input array,
#       followed by either a strong-wiggle-sorted version of the input,
#       or by "timed out" if no valid sorting could be found in 1000 attempts.

# Preliminaries:
use v5.36;

# Default Inputs:
my @arrays=
(
   [1,5,1,1,6,4],
   [1,3,2,2,3,1]
);

# Non-Default Input:
if (@ARGV) {@arrays=([@ARGV])}

# Main body of script:
ARRAY : for (@arrays){                               # For each input array.
   my @array = @{$_};                                # Current input array.
   say '';                                           # Print blank line.
   say "Input  = (@array)";                          # Print input.
   my $flag = 1;                                     # We have work to do.
   my $shifts = 0;                                   # How many shifts have we worked?
   while ( $flag ){                                  # Loop while we have work to do.
      if ( $shifts >=1000 ){                         # But if we've worked 1000 shifts,
         say "timed out";                            # and yet the work still ain't done,
         next ARRAY;}                                # then give up.
      ++$shifts;                                     # Yet another work shift.
      $flag = 0;                                     # Work is done, maybe?
      for ( my $i = 0 ; $i <= $#array - 1 ; ++$i ){  # For each index pair:
         if ( $i % 2 ){                              # If (odd,even) pair:
            if ( $array[$i] <= $array[$i+1] ){       # If pair isn't downward-trending,
               $flag = 1;                            # work's not done.
               my $temp = $array[$i];                # swap
               $array[$i] = $array[$i+1];            # swap
               $array[$i+1] = $temp;}}               # swap
         else {                                      # Else if (even,odd) pair:
            if ( $array[$i] >= $array[$i+1] ){       # If pair isn't upward-trending,
               $flag = 1;                            # work's not done.
               my $temp = $array[$i];                # swap
               $array[$i] = $array[$i+1];            # swap
               $array[$i+1] = $temp;}}}}             # swap
   say "Output = (@array)";}                         # Print output.