#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK2
#
# Task 2: Reshape Matrix
#
# You are given a matrix (m x n) and two integers (r) and (c).
#
# Write a script to reshape the given matrix in form (r x c) with the original
# value in the given matrix. If you can’t reshape print 0.
#
## Example 1
##
## Input: [ 1 2 ]
##        [ 3 4 ]
##
##        $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
##        $r = 1
##        $c = 4
##
## Output: [ 1 2 3 4 ]
#
## Example 2
##
## Input: [ 1 2 3 ]
##        [ 4 5 6 ]
##
##        $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
##        $r = 3
##        $c = 2
##
## Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
##
##         [ 1 2 ]
##         [ 3 4 ]
##         [ 5 6 ]
#
## Example 3
##
## Input: [ 1 2 ]
##
##        $matrix = [ [ 1, 2 ] ]
##        $r = 3
##        $c = 2
##
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# So first we check our input to find m and n from our (m x n) matrix.
# If then m*n != $r * $c we can return 0 right away.
# Otherwise, flatten the matrix and select $r arrays of $c elements
# as the new matrix.
#
use strict;
use warnings;

my @examples = (
   [ [ [ 1, 2 ], [ 3, 4 ] ], 1, 4 ],
   [ [ [ 1, 2, 3 ], [ 4, 5, 6] ], 3, 2],
   [ [ [ 1, 2 ] ], 3, 2]
);
foreach my $example (@examples) {
   my ($matrix, $r, $c) = @$example;
   print_reshaped_matrix($matrix, $r, $c);
}

# given the matrix, $r and $c let's reshape the matrix
sub print_reshaped_matrix {
   my ($matrix, $r, $c) = @_;
   # print the input matrix first
   print "Input:\n";
   print_matrix($matrix);
   # fetch the individual arrays from the matrix and
   # calculate m and n
   my @arrays = @$matrix;
   my $n = scalar(@arrays);
   my $m = scalar(@{$arrays[0]});
   # sanity check to see whether this is actually a matrix
   foreach my $array (@arrays) {
      die "Not a matrix" if scalar(@$array) != $m;
   }
   # m*n != $r*$c => we can't create the output matrix, exit immediately
   if ($r*$c != $m*$n) {
      print "Output: 0\n";
      return;
   }
   # flatten the matrix
   my @elements = flatten($matrix);
   my @result = ();
   # calculate the arrays for the target matrix
   foreach my $index (0..$r-1) {
      # calculate the current slice. It starts at $index * $c,
      # while the end is one less than the beginning of the next
      # slice (or the end of data)
      my $start = $index * $c;
      my $end = ($index+1) * $c - 1;
      # get the slice and push it onto the result matrix
      my @tmp = @elements[$start..$end];
      push @result, [ @tmp ];
   }
   # print the output
   print "Output:\n";
   print_matrix(\@result);
}

# flatten a matrix into an array
sub flatten {
   my $matrix = shift;
   my @elements = ();
   foreach my $array (@$matrix) {
      push @elements, @$array;
   }
   return @elements;
}

# print a given matrix
sub print_matrix {
   my $matrix = shift;
   my $first = 1;
   print "[ " unless scalar(@$matrix) == 1;
   foreach my $array (@$matrix) {
      if($first) {
         $first = 0;
      } else {
         print " , ";
      }
      print "[ " . join(", ", @$array) . " ]";
   }
   print " ]" unless scalar(@$matrix) == 1;
   print "\n";
}

