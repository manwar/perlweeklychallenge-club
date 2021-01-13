#!env raku
#
# Perl Weekly Challenge 53
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/>
#
# Task 1
#
# Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
#
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# 
# For example, if you rotate by 90 degrees then expected result should be like below
# 
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]
#
#
#
# Example of invocation
#     % raku ch-1.p6 180
#         Rotation is 180
#         Original matrix is 
#         | 1 | 2 | 3 | 
#         | 4 | 5 | 6 | 
#         | 7 | 8 | 9 | 
#         Rotated matrix is 
#         | 9 | 8 | 7 | 
#         | 6 | 5 | 4 | 
#         | 3 | 2 | 1 | 
#     


sub MAIN( Int:D $rotation  where { $rotation == any( 90, 180, 270 ) } = 90 ) {

   say "Rotation is $rotation";

   my @matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ];
   say "Original matrix is ";
   say " | " ~ $_.join( " | " ) ~ " | " for @matrix;

   my @rotated-matrix;

   # do a loop for all the rotation
   for 1 .. $rotation / 90 {

       # the matrix is a square matrix, move on the columns
       # to get the rotated row
       for 0 .. @matrix.elems - 1 -> $current-column {
           my @rotated-row;
           for 0 .. @matrix.elems - 1 {
               @rotated-row.push: @matrix[ @matrix.elems - 1 - $_ ][ $current-column ]
           }

           # push the rotated row to the new matrix
           @rotated-matrix.push: [ @rotated-row ];
       }

       # switch the matrix, in the case we need to loop further
       @matrix = @rotated-matrix;
       @rotated-matrix = [];
   }

   say "Rotated matrix is ";
   say " | " ~ $_.join( " | " ) ~ " | " for @matrix;

}
