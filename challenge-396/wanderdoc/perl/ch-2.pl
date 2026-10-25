#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integer.

Write a script to return true if the given array is Trionic otherwise return false.

    An array is trionic if there exist indices 0 < p < q < n − 1 such that arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing, and arr[q…n − 1] is strictly increasing.

Example 1

Input: @arr = (1, 3, 5, 4, 2, 6, 8)
Output: true

Choose p = 2 and q = 4
$arr[0..2] = (1, 3, 5) (strictly increasing)
$arr[2..4] = (5, 4, 2) (strictly decreasing)
$arr[4..6] = (2, 6, 8) (strictly increasing)

Valid indices: 0 < p (2) < q (4) < n-1 (6).

Example 2

Input: @arr = (1, 4, 4, 2, 1, 3, 5)
Output: false

The first segment (1, 4, 4) contains duplicate adjacent values, so it is not strictly increasing.
No valid p and q exist to satisfy all three strictly monotonic conditions.

Example 3

Input: @arr = (2, 10, 3, 1, 9)
Output: true

Choose p = 1 and q = 3.
$arr[0..1] = (2, 10)    (strictly increasing)
$arr[1..3] = (10, 3, 1) (strictly decreasing)
$arr[3..4] = (1, 9)     (strictly increasing)

Example 4

Input: @arr = (1, 2, 3, 4, 3, 2, 1)
Output: false

This is a standard mountain array (strictly increasing, then strictly decreasing).
There is no second valley (q) that transitions back into a strictly increasing third segment before reaching the end of the array.

Example 5

Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
Output: false
=cut

use Test2::V0 -no_srand => 1;
use Data::Dump;

is(is_trionic(1, 3, 5, 4, 2, 6, 8), 1, 'Example 1');
is(is_trionic(1, 4, 4, 2, 1, 3, 5), 0, 'Example 2');
is(is_trionic(2, 10, 3, 1, 9), 1, 'Example 3');
is(is_trionic(1, 2, 3, 4, 3, 2, 1), 0, 'Example 4');
is(is_trionic(1, 3, 6, 4, 2, 7, 8, 4), 0, 'Example 5');
done_testing();


sub is_trionic
{
     my @arr = @_; 
     my $direction = 0;
     my $counter = 0;
     my $previous = $arr[0];
     my @borders; 
     
     for my $idx (1 .. $#arr)
     {
          if ( ($arr[$idx] < $previous and $direction != -1) 
               or
               ($arr[$idx] > $previous and $direction != 1)
               )
          {
               $counter++;
               return 0 if $counter > 3;
               $direction = $arr[$idx] < $previous ? -1 : 1;
               push @borders, $idx - 1;
          }
          elsif ( $arr[$idx] == $previous )
          {
               return 0;
          }
          $previous = $arr[$idx]; 
     }
     push @borders, $#arr;
     dd \@borders;
     if ( $counter != 3 )
     {
          return 0;
     }
     return 1;
}
