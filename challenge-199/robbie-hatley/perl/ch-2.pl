#! /usr/bin/perl

# /d/rhe/PWCC/199/ch-2
# "Good Triplets"

=pod

Task 2: Good Triplets
Submitted by: Mohammad S Anwar

You are given an array of integers, @array, and three integers 
$x,$y,$z. Write a script to find out total Good Triplets in 
the given array. A triplet array[i], array[j], array[k] is a
"Good Triplet" if it satisfies the following conditions:
a) 0 <= i < j < k < n (size of given array)
b) abs(array[i] - array[j]) <= x
c) abs(array[j] - array[k]) <= y
d) abs(array[k] - array[i]) <= z

Example 1:  
Input:  @array = (3,0,1,1,9,7), $x = 7, $y = 2, $z = 3
Output: 4

Example 2:
Input:  @array = (1,1,2,2,3), $x = 0, $y = 0, $z = 1
Output: 0

=cut

# IO NOTES:

# NOTE: Input is via built-in array of arrays, or via @ARGV.
#       If using @ARGV, input should be a space-separated list
#       of integers; the final 3 will be construed as being
#       $x, $y, $z and the remainder as being @array.

# NOTE: Output is to stdout and will be the input array and
#       parameters followed by number of Good Triplets found.

# PRELIMINARIES:

use v5.36;
$" = ', ';

# DEFAULT INPUT:
my @arrays = ([3,0,1,1,9,7,7,2,3],[1,1,2,2,3,0,0,1]);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @array = @{$_};
   my $z = pop @array;
   my $y = pop @array;
   my $x = pop @array;
   my @good;
   for (       my $i =    0   ; $i <= $#array - 2 ; ++$i ){
      for (    my $j = $i + 1 ; $j <= $#array - 1 ; ++$j ){
         for ( my $k = $j + 1 ; $k <= $#array - 0 ; ++$k ){
            if   (   abs($array[$i] - $array[$j]) <= $x
                  && abs($array[$j] - $array[$k]) <= $y
                  && abs($array[$k] - $array[$i]) <= $z){
               push @good, [@array[$i, $j, $k]];}}}}
   my $good_count = scalar(@good);
   say '';
   say "array = (@array)";
   say "Found $good_count \"Good Triplets\" of array values:";
   say "(@{$_})" for @good}