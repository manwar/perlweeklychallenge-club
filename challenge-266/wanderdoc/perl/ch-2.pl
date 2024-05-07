#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a square matrix, $matrix.

Write a script to find if the given matrix is X Matrix.

    A square matrix is an X Matrix if all the elements on the main diagonal and antidiagonal are non-zero and everything else are zero.

Example 1

Input: $matrix = [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
Output: true

Example 2

Input: $matrix = [ [1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9],
                 ]
Output: false

Example 3

Input: $matrix = [ [1, 0, 2],
                   [0, 3, 0],
                   [4, 0, 5],
                 ]
Output: true
=cut

use Test2::V0;


my $mtr_1 = [ [1, 0, 0, 2],
              [0, 3, 4, 0],
              [0, 5, 6, 0],
              [7, 0, 0, 1],
            ];

my $mtr_2 = [ [1, 2, 3],
              [4, 5, 6],
              [7, 8, 9],
                 ];

my $mtr_3 = [ [1, 0, 2],
              [0, 3, 0],
              [4, 0, 5],
                 ];



is(is_x_matrix($mtr_1), 1, 'Example 1');
is(is_x_matrix($mtr_2), 0, 'Example 2');
is(is_x_matrix($mtr_3), 1, 'Example 3');

done_testing();
                 
sub is_x_matrix
{
     my $mtr = $_[0];
     my $max_idx = $#$mtr;
     for my $y ( 0 .. $max_idx )
     {
          for my $x ( 0 .. $max_idx ) # square matrix
          {
               return 0 
                    if ($x == $y and $mtr->[$y][$x] == 0)
                    or ($x == ($max_idx - $y) and $mtr->[$y][$x] == 0)
                    or ($x != $y and $x != ($max_idx - $y) 
                                 and $mtr->[$y][$x] != 0);
          }
     }
     return 1;
}