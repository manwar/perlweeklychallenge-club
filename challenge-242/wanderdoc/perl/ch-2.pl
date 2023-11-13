#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given n x n binary matrix. Write a script to flip the given matrix as below.
1 1 0
0 1 1
0 0 1
a) Reverse each row
0 1 1
1 1 0
1 0 0
b) Invert each member
1 0 0
0 0 1
0 1 1

Example 1
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
Example 2
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
=cut

use Test2::V0;


sub flip_matrix
{
     my $mtr = $_[0];
     for my $row ( @{$mtr} )
     {
          @{$row} = reverse @{$row};
          @{$row} = map { abs($_ -= 1) } @{$row};
     }
     return $mtr;
}


is(flip_matrix( [[1, 1, 0], [1, 0, 1], [0, 0, 0]] ),
     [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'Example 1');
is(flip_matrix( [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]] ),
     [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], 'Example 2');
done_testing();