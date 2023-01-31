#! /usr/bin/perl

# Robbie Hatley's Perl Solutions to The Weekly Challenge #202-1

# DESCRIPTION OF PROBLEM:

=pod

Task 1: Consecutive Odds
Submitted by: Mohammad S Anwar

You are given an array of integers. Write a script to print 1 if there 
are THREE consecutive odds in the given array otherwise print 0.

Example 1:  Input: (1,5,3,6)  Output: 1
Example 2:  Input: (2,6,3,5)  Output: 0
Example 3:  Input: (1,2,3,4)  Output: 0
Example 4:  Input: (2,3,5,7)  Output: 1

=cut

# IO NOTES:
# NOTE: Default input is via built-in array of arrays.
#       Non-default input can be provided through @ARGV.
#       If using @ARGV, arguments should be a space-separated sequence
#       of integers, which will be construed as being a single array.
#
# NOTE: Output is to stdout and will be 1 if 3 consecutive odds, else 0.

# PRELIMINARIES:
use v5.36;
$,=' ';

# SUBROUTINES: 
sub tco (@a){
   for (my $i = 0 ; $i <= $#a-2 ; ++$i){
      if ( !($a[$i+0]%2) ) {$i += 0; next;}
      if ( !($a[$i+1]%2) ) {$i += 1; next;}
      if ( !($a[$i+2]%2) ) {$i += 2; next;}
      return 1;}
   return 0;}

# DEFAULT INPUT:
my @arrays = ([1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV]);}

# SCRIPT BODY:
for (@arrays){
   my @array = @{$_};
   my $tco = tco(@array);
   say '';
   say "array = (@array)";
   say "tco = $tco";}