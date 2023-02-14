#! /usr/bin/perl
# Robbie Hatley's Solution to PWCC 204-2

=pod

Task 2: Reshape Matrix
Submitted by: Mohammad S Anwar
Given an m-by-n matrix @m and two integers $r and $c, write a script to
reshape @m to r-by-c, re-using all of the original elements of @m.
If this is not possible, just print 0.

Example 1:
Inputs:
   old shape:
      rows = 2
      cols = 2
   matrix:
      1  2
      3  4
   new shape:
      rows = 1
      cols = 4
Output:
   1  2  3  4

Example 2:
Inputs:
   old shape:
      rows = 2
      cols = 3
   matrix:
      1  2  3
      4  5  6
   new shape:
      rows = 3
      cols = 2
Output:
   1  2
   3  4
   5  6

Example 3:
Input:
   old shape:
      rows = 1
      cols = 2
   matrix:
      1  2
   new shape:
      rows = 3
      cols = 2
Output:
   0

=cut

# IO NOTES:
#
# NOTE: Input is by either built-in array-of-arrays, or @ARGV.
#
#       If using @ARGV,the args should be a space-separated sequence of
#       integers, which should be the numbers of rows & columns of the
#       original matrix, followed by the elements of the matrix in
#       left-to-right-within-up-to-down order (like reading a book),
#       followed by the numbers of rows & columns desired. For example,
#       to reshape the matrix ([5,8],[1,4]) from 2-by-2 to 4-by-1:
#       ./ch-2.pl 2 2 5 8 1 4 4 1
#
# NOTE: Output is to STDOUT and will be the original matrix, followed by
#       the reshaped matrix (or 0 if the matrix can't be reshaped to
#       the given shape).

# PRELIMINARIES:
use v5.36;
$"=" ";

# SUBROUTINES:

sub shape {
   my $r = shift @_;
   my $c = shift @_;
   my @flat = @_;
   if ($r*$c != scalar @flat){
      return ([0])}
   my @rows;
   my $i = 0;
   for (@flat){
      $rows[int $i/$c]->[$i%$c]=$_;
      ++$i}
   return @rows}

# DEFAULT INPUTS:
my @arrays =
(
   [2,2,1,2,3,4,1,4], 
   [2,3,1,2,3,4,5,6,3,2], 
   [1,2,1,2,3,2]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
for (@arrays){
   say '';
   my @array = @{$_};
   my $or = shift @array;
   my $oc = shift @array;
   my $nc = pop   @array;
   my $nr = pop   @array;
   my @old_rows = shape($or, $oc, @array);
   my @new_rows = shape($nr, $nc, @array);
   say "Original matrix ($or rows, $oc cols):";
   say "@{$_}" for @old_rows;
   say "Reshaped matrix ($nr rows, $nc cols):";
   say "@{$_}" for @new_rows;
   if (1 == @new_rows && 1 == @{$new_rows[0]} && 0 == $new_rows[0]->[0]){
      say "(Couldn't reshape.)"}}