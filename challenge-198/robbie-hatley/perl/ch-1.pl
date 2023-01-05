#! /usr/bin/perl

# Robbie Hatley's Perl solution to Weekly Challenge #197-1.

# PROBLEM DESCRIPTION:

=pod

Task 1: Max Gap
Submitted by: Mohammad S Anwar

Given a list of integers, write a script to find the total pairs of
consecutive elements of the sorted list which have max gap.
If the list contains less then 2 elements then return 0.

Example 1:  Input:  (2,5,8,1)  Output: 2
Example 2:  Input:  (3)        Output: 0

=cut


# IO NOTES:

# NOTE: Input is from either the built-in array of arrays,
#       or from @ARGV. If using @ARGV, the arguments should be
#       a space-separated list of integers.

# NOTE: Output will be to stdout and will be max gap.

# PRELIMINARIES:
use v5.36;

# DEFAULT INPUTS:
my @arrays = ([2,5,8,1], [3]);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @array  = @{$_};
   my @sorted = sort {$a<=>$b} @array;
   my $gap = 0; # Gap.
   my $max = 0; # Max gap.
   my $cnt = 0; # Count of pairs with max gap.
   for ( my $i = 0 ; $i < $#sorted ; ++$i ) {
      $gap = $sorted[$i+1]-$sorted[$i];
      if    ( $gap  < $max ) {;}                 # Do nothing.
      elsif ( $gap == $max ) {++$cnt;}           # Increment count.
      elsif ( $gap  > $max ) {$max=$gap;$cnt=1;} # New max, new count.
      else {die "Cthulhu wgah'nagl fhtagn.\n";}} # This can't happen.
   say '';
   say "array   = @array";
   say "max gap = $gap";
   say "count   = $cnt";}