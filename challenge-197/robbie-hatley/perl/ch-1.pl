#! /usr/bin/perl

# Robbie Hatley's Perl solution to challenge 197-1

=pod

Task 1: Move Zero
Submitted by: Mohammad S Anwar
You are given a list of integers, @list. Write a script to move all zeros,
if any exist, to the end of the list, while maintaining the relative order
of non-zero elements.

Example 1: Input: (1, 0, 3, 0, 0, 5)  Output: (1, 3, 5, 0, 0, 0)
Example 2: Input: (1, 6, 4)           Output: (1, 6, 4)
Example 3: Input: (0, 1, 0, 2, 0)     Output: (1, 2, 0, 0, 0)

=cut

# NOTE: Input is from built-in array or command-line args.
#       If using args, they should be space-separated integers.

# NOTE: Output is to stdout and will be a printout of each input array,
#       followed by the same with all 0s moved to end.

# Preliminaries:
use v5.36;
use List::Util 'sum0';

# Default Inputs:
my @lists =
   (
      [1, 0, 3, 0, 0, 5],
      [1, 6, 4],
      [0, 1, 0, 2, 0]
   );

# Non-Default Input:
if (@ARGV) {@lists=([@ARGV])}

# Move zero! Move zero! For great justice, take off every zero!
# ~~AYBABTU

for (@lists){
   my @list = @{$_};                        # Input.
   my $z;                                   # A placeholder for a 0.
   say '';                                  # Print blank line.
   say "Input  = (@list)";                  # Announce input.
   for ( my $i = 0 ; $i <= $#list ; ++$i ){ # Riffle through list.
      last if 0 == sum0(@list[$i..$#list]); # Stop if all remaining elements are 0.
      if ( 0 == $list[$i] ){                # If we find a 0,
         $z = splice @list, $i, 1;          # splice it from current position
         splice @list, @list, 0, $z;        # and paste it on end.
         --$i;}}                            # Back-up one spot,
                                            # because we altered current location.
   say "Output = (@list)";}                 # Print output.