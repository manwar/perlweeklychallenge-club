#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two sorted arrays.

Write a script to merge the two given sorted arrays and return the median of the merged array.
Example 1

Input: @arr1 = (2), @arr2 = (4)
Output: 3.0

Merged array: (2,4)
Median: (2+4)/2 => 3

Example 2

Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
Output: 7.0

Merged array: (1,2,3,7,8,9,10)
Length of merged array is 7, the 4th element is 7.

Example 3

Input: @arr1 = (), @arr2 = (10,20,30,40)
Output: 25.0

Merged array: (10,20,30,40)
Median: (20+30)/2 => 25

Example 4

Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
Output: 4.5

Merged array: (1,2,3,4,5,6,7,100)
Median: (4+5)/2 => 4.5

Example 5

Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
Output: 2.0

Merged array: (1,2,2,2,2,3)
Median: (2+2)/2 => 2
=cut


use Test2::V0 -no_srand => 1;
is(array_median((2), (4)), 3, 'Example 1');
is(array_median((1, 2, 3), (7, 8, 9, 10)), 7, 'Example 2');
is(array_median((), (10, 20, 30, 40 )), 25, 'Example 3');
is(array_median((100), (1, 2, 3, 4, 5, 6, 7)), 4.5, 'Example 4');
is(array_median((1,2,2), (2,2,3)), 2, 'Example 5');
done_testing();


sub array_median
{
     # my ($aref_1, $aref_2) = @_;
     my @arr = sort {$a <=> $b} @_; # @$aref_1, @$aref_2;
     my $length = scalar @arr;      my $median;
     if ( $length % 2 )
     {
          $median = $arr[int($length/2)];
     }
     else
     {
          $median = ($arr[$length/2 - 1] + $arr[$length/2])/2;
     }
     return $median;
}
