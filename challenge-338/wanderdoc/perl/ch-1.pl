#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a m x n matrix.
Write a script to find the highest row sum in the given matrix.
Example 1
Input: @matrix = ([4,  4, 4, 4],
                  [10, 0, 0, 0],
                  [2,  2, 2, 9])
Output: 16

Row 1: 4  + 4 + 4 + 4 => 16
Row 2: 10 + 0 + 0 + 0 => 10
Row 3: 2  + 2 + 2 + 9 => 15


Example 2

Input: @matrix = ([1, 5],
                  [7, 3],
                  [3, 5])
Output: 10


Example 3

Input: @matrix = ([1, 2, 3],
                  [3, 2, 1])
Output: 6


Example 4

Input: @matrix = ([2, 8, 7],
                  [7, 1, 3],
                  [1, 9, 5])
Output: 17


Example 5

Input: @matrix = ([10, 20,  30],
                  [5,  5,   5],
                  [0,  100, 0],
                  [25, 25,  25])
Output: 100

=cut

use PDL; # Run with strawberry-perl-5.40.0.1-64bit-PDL
use Test2::V0 -no_srand => 1;

is(max_row([[4,  4, 4, 4], [10, 0, 0, 0], [2,  2, 2, 9]]), 16, 'Example 1');
is(max_row([[1, 5], [7, 3], [3, 5]]), 10, 'Example 2');
is(max_row([[1, 2, 3], [3, 2, 1]]), 6, 'Example 3');
is(max_row([[2, 8, 7], [7, 1, 3], [1, 9, 5]]), 17, 'Example 4');
is(max_row([[10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]]), 100, 'Example 5');
done_testing;

sub max_row
{
     my $mtr = $_[0];
     my $pdl = pdl @$mtr; # print $pdl->transpose; (for sum on columns)
     my $sums = sumover $pdl;
     return $sums->maximum;
}
