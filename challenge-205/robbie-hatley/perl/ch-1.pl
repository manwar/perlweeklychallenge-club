#! /usr/bin/perl
# Robbie Hatley's Solution to PWCC 205-1

=pod

Task 1: Third Highest
Submitted by: Mohammad S Anwar
Given an array of integers, write a script to find out the third-highest unique value, if the number of unique values
is at least 3; otherwise, return the maximum unique value.
Example 1:   Input: (5,3,4)     Output: 3
Example 2:   Input: (5,6)       Output: 6
Example 3:   Input: (5,4,4,3)   Output: 3

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV. If using @ARGV,the args should be a space-separated
#       sequence of integers, which will be interpreted as being a single array.
# NOTE: Output is to STDOUT and will be the third-highest unique value if the number of unique values is at least 3;
#       otherwise, the output will be the maximum unique value.

# PRELIMINARIES:
use v5.36;
use List::Util 'uniqint';
$"=", ";

# DEFAULT INPUTS:
my @arrays = ([5,4,3], [5,6], [5,4,4,3]);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
for (@arrays){
   say '';
   my @array = @{$_};
   say "array: (@array)";
   my @unique = uniqint reverse sort @array;
   if (@unique >= 3) {say "Third-highest unique value = $unique[2]"}
   else              {say "Maximum unique value = $unique[0]"}}