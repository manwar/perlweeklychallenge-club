#! /bin/perl
# Robbie Hatley's Perl solutions to The Weekly Challenge #211-2

# ======================================================================
# PROBLEM DESCRIPTION:

=pod

Task 2: Split Same Average
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to find out if the 
given can be split into two separate arrays whose average are the same.

Example 1:  Input=(1, 2, 3, 4, 5, 6, 7, 8)  Output=true
Example 2:  Input=(1, 3)                    Output=false

=cut

# ======================================================================
# INPUT / OUTPUT NOTES:
# Input is from built-in array-of-arrays or from @ARGV. If using @ARGV,
# input should be one 'single-quoted' string expressing an array of 
# arrays of integers in valid Perl syntax.
#
# Output is to STDOUT and will be input array followed by either 
# a split with equal averages or a notice that no such split exists.

# ======================================================================
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use Set::Partition;
use List::AllUtils 'sum0';
$"=', ';

# ======================================================================
# VARIABLES:
my $db = 0; # Debug?

# ======================================================================
# SUBROUTINES:

# Obtain an array of all partitions of a given set into two non-empty
# parts with the size of the first part not-greater-than the size of the
# second part (to avoid duplicate partitions):
sub two_non_empty ($aref){
   # How big is the original array?
   my $size  = scalar(@{$aref});
   # Make an array to hold partitions:
   my @partitions;
   # No need to allow the first part to be more than half the size
   # of the array, else we'd get duplicate partitions:
   my $limit = int($size/2);
   for ( my $n = 1 ; $n <= $limit ; ++$n ){
      my $size_n_partitions = Set::Partition->new(
         list      => $aref,
         partition => [$n, $size - $n],
      );
      while (my $partition = $size_n_partitions->next) {
         push @partitions, $partition;
      }
   }
   return \@partitions;
}

# What is the average of the real numbers in a referred-to array?
sub average ($aref) {return sum0(@$aref)/scalar(@$aref);}

# Are two floating-point numbers "equal" to within one millionth?
sub equal ($x, $y) {abs($x-$y) < 0.000001 ? return 1 : return 0;}

# ======================================================================
# DEFAULT INPUTS:
my @arrays = 
(
   [1, 2, 3, 4, 5, 6, 7, 8],
   [1, 3],
   [3, 6, -2.3, 8.64, 5.36],
   [3, 6, -2, 8, 5],
   [4, 6, 8, 9]
);

# ======================================================================
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0])}

# ======================================================================
# MAIN BODY OF SCRIPT:

ARRAY: for (@arrays){
   say '';
   say "array = (@$_)";
   my $partitions = two_non_empty($_);
   my $equal_average_flag = 0;
   # If debugging, print lots of extra diagnostics:
   if ($db) {
      say 'Partitions:';
      for (@$partitions){
         my $a1 = average($_->[0]);
         my $a2 = average($_->[1]);
         my $e = equal($a1, $a2) ? 'EQUAL!!!' : '';
         say("(@{$_->[0]}) (@{$_->[1]}) $a1 $a2 $e");
      }
   }
   # Otherwise, just print the basics:
   else {
      for (@$partitions){
         my $a1 = average($_->[0]);
         my $a2 = average($_->[1]);
         if (equal($a1, $a2)) {
            say 'array can be split into '
              . "(@{$_->[0]}) and (@{$_->[1]}), "
              . "both with average $a1";
            next ARRAY;
         }
      }
      say 'No equal-average split exists.';
   }
}
