#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints and a target element $k. Write a script to return the list of indices in the sorted array where the element is same as the given target element.

Example 1
Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
Output: (1, 2)
Sorted array: (1, 2, 2, 3, 4, 5)
Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2

Example 2
Input: @ints = (1, 2, 4, 3, 5), $k = 6
Output: ()
No element in the given array matching the given target.

Example 3

Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
Output: (4)
Sorted array: (1, 2, 2, 3, 4, 5)
Target index: (4) as $ints[4] = 4
=cut

use Sort::Key qw(nkeysort);
use List::MoreUtils qw(indexes);
use integer;
use Test2::V0;

is(target_index([1, 5, 3, 2, 4, 2], 2), [1, 2], 'Example 1');
is(target_index([1, 2, 4, 3, 5], 6), [], 'Example 2');
is(target_index([5, 3, 2, 4, 2, 1], 4), [4], 'Example 3');
done_testing();

sub target_index
{
     my ($aref, $elm) = @_;
     return
          [indexes { $_ == $elm } nkeysort {$_} @$aref];
}







# use Data::Dump; 
# dd target_index([1, 5, 3, 2, 4, 2], 2);
# dd target_index([1, 2, 4, 3, 5], 6);
# dd target_index([5, 3, 2, 4, 2, 1], 4);