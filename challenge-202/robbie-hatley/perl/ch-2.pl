#! /usr/bin/perl

# Robbie Hatley's Perl Solutions to The Weekly Challenge #202-2

# DESCRIPTION OF PROBLEM:

=pod

Task 2: Widest Valley
Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost widest valley.
A valley is defined as a subarray of the profile consisting of two parts:
the first part is non-increasing and the second part is non-decreasing.
Either part can be empty.

Example 1:  Input: 1, 5, 5, 2, 8               Output: 5, 5, 2, 8
Example 2:  Input: 2, 6, 8, 5                  Output: 2, 6, 8
Example 3:  Input: 9, 8, 13, 13, 2, 2, 15, 17  Output: 13, 13, 2, 2, 15, 17
Example 4:  Input: 2, 1, 2, 1, 3               Output: 2, 1, 2
Example 5:  Input: 1, 3, 3, 2, 1, 2, 3, 3, 2   Output: 3, 3, 2, 1, 2, 3, 3

=cut

# IO NOTES:
#
# NOTE: Input is via either built-in array of arrays, or @ARGV.
#       If using @ARGV, arguments should be a space-separated sequence of
#       integers, which will be interpreted as being a single array
#
# NOTE: Output will be to stdout and will be the contents of each array
#       followed by the left-most widest valley within that array.

# PRELIMINARIES:
use v5.36;
$"=", ";

# DEFAULT INPUT:
my @arrays =
(
   [1, 5, 5, 2, 8], 
   [2, 6, 8, 5], 
   [9, 8, 13, 13, 2, 2, 15, 17], 
   [2, 1, 2, 1, 3], 
   [1, 3, 3, 2, 1, 2, 3, 3, 2]
);

# NON-DEFAULT INPUT:
if (@ARGV){@arrays=([@ARGV])}

# SCRIPT BODY:
for (@arrays){
   my @array   = @{$_};  # Current array.
   my $state   = 'L';    # State of valley wall: 'L'=Left, 'R'=Right.
   my $width   = 0;      # Width of most-recent valley.
   my $widbi   = 0;      # Beginning index of widest valley found so far.
   my $widest  = 0;      # Width of widest valley found so-far.
   my @valley  = ();     # Left-most widest valley found so far.
   my $el      = 0;      # Current elevation number.
   my $idx     = 0;      # Elevation index.
   my $begin   = 0;      # Beginning index of current valley.
   
   # For each elevation change, decide what to do, based valley-wall state
   # and on whether we've reached the last elevation yet:
   for ( $idx = 1 ; $idx <= $#array ; ++$idx ){

      # If we're on the Left Wall of our current valley, check to see if we
      # just transitioned to the Right Wall:
      if ($state eq 'L' && $array[$idx] > $array[$idx-1]){
         $state = 'R';}

      # If we're on the Right Wall of our current valley, check to see if we
      # just transitioned to a new Left Wall:
      if ($state eq 'R' && $array[$idx] < $array[$idx-1]){
         # How wide was that valley we just left?
         $width = $idx - $begin;

         # Was that wider than the widest valley we've seen so far?
         # If so, update widest-valley information accordingly:
         if ($width > $widest){
            $widbi  = $begin;
            $widest = $width;}

         # Our old valley ended, so now let's begin a new valley:
         $begin = $idx;

         # But also include any flat or down-sloping ground to the left
         # of $idx as also being part of our new valley:
         while ($begin >= 0 && $array[$begin-1]>=$array[$begin]){--$begin}

         # We're now on the left wall of our new valley:
         $state = 'L';}

      # If end-of-array cuts off valley, then don't wait for current valley to
      # terminate by R->L transition, because that can't happen! Instead,
      # calculate size of current valley now, and update "widest valley"
      # information if appropriate:
      if ($idx == $#array){
         $width = $idx + 1 - $begin;
         if ($width > $widest){
            $widbi  = $begin;
            $widest = $width;}}}

   # Set @valley to a slice of @array beginning with "widest beginning index"
   # "$widbi" and having width "$widest":
   @valley = @array[$widbi..$widbi+$widest-1];

   # Print results:
   say '';
   say "Array of elevations     = (@array)";
   say "Left-most widest valley = (@valley)"}
