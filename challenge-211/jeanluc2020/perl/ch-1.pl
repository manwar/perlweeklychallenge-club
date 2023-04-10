#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-211/#TASK1
#
# Task 1: Toeplitz Matrix
# =======================
#
# You are given a matrix m x n.
#
# Write a script to find out if the given matrix is Toeplitz Matrix.
#
## A matrix is Toeplitz if every diagonal from top-left to bottom-right has the
## same elements.
#
## Example 1
##
## Input: @matrix = [ [4, 3, 2, 1],
##                    [5, 4, 3, 2],
##                    [6, 5, 4, 3],
##                  ]
## Output: true
#
## Example 2
##
## Input: @matrix = [ [1, 2, 3],
##                    [3, 2, 1],
##                  ]
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We just need to walk all diagonals and check if all numbers are
# the same. But actually it's easier to walk the matrix and check
# whether the element to the right bottom of the current one differs
# from the current one. When we do that everywhere we can know
# whether all diagonals have the same number everywhere as well,
# so let's do that.

toeplitz([ [4, 3, 2, 1],
           [5, 4, 3, 2],
           [6, 5, 4, 3] ]);
toeplitz([ [1, 2, 3],
           [3, 2, 1] ]);

sub toeplitz {
   my $matrix = shift;
   die "Not a matrix" unless is_matrix($matrix);
   # get the dimensions of the matrix
   my $lines = scalar(@$matrix);
   my $columns = scalar(@{$matrix->[0]});
   # for each line and column except the last one, compare the element
   # at that position and the one on the right bottom of it
   foreach my $i (0..$lines-2) {
      foreach my $j (0..$columns-2) {
         my $this_element = $matrix->[$i]->[$j];
         my $next_diagonal_element = $matrix->[$i+1]->[$j+1];
         if ($this_element != $next_diagonal_element) {
            print "Output: false\n";
            return;
         }
      }
   }
   print "Output: true\n";
}

# helper function to check if we actually have a matrix
sub is_matrix {
   my $matrix = shift;
   return 0 unless ref($matrix) eq "ARRAY";
   my $columns = scalar(@{$matrix->[0]});
   foreach my $line (@$matrix) {
      return 0 unless scalar(@$line) == $columns;
   }
   return 1;
}

