#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two array of integers, @order and @friends.

The @order (size n) contains every integer from 1 to n exactly once. The @friends contains ID in sorted in strictly increasing order.

Write a script to return the array containing IDs in finishing order.
Example 1

Input: @order = (3, 1, 4, 2, 5)
       @friends = (1, 2, 4)
Output: (1, 4, 2)

ID 1 finished 2nd.
ID 4 finished 3rd.
ID 2 finished 4th.

Example 2

Input: @order = (5, 4, 3, 2, 1)
       @friends = (1, 3, 5)
Output: (5, 3, 1)

ID 5 finished 1st.
ID 3 finished 3rd.
ID 1 finished 5th.

Example 3

Input: @order = (2, 4, 1, 3)
       @friends = (1, 2, 3, 4)
Output: (2, 4, 1, 3)

ID 2 finished 1st.
ID 4 finished 2nd.
ID 1 finished 3rd.
ID 3 finished 4th.

Example 4

Input: @order = (4, 1, 3, 2)
       @friends = (3)
Output: (3)

Example 5

Input: @order = (1, 3, 2, 6, 5, 4)
       @friends = (1, 2, 3)
Output: (1, 3, 2)

ID 1 finished 1st.
ID 3 finished 2nd.
ID 2 finished 3rd.
=cut


use Test2::V0 -no_srand => 1;
is([finishing_order([3, 1, 4, 2, 5], [1, 2, 4])], [1, 4, 2], 'Example 1');
is([finishing_order([5, 4, 3, 2, 1], [1, 3, 5])], [5, 3, 1], 'Example 2');
is([finishing_order([2, 4, 1, 3], [1, 2, 3, 4])], [2, 4, 1, 3], 'Example 3');
is([finishing_order([4, 1, 3, 2], [3])], [3], 'Example 4');
is([finishing_order([1, 3, 2, 6, 5, 4], [1, 2, 3])], [1, 3, 2], 'Example 5');
done_testing();

sub finishing_order
{
     my ($order, $friends) = @_;
     my %choose = map { $_ => undef } @$friends;
     return grep { exists $choose{$_} } @$order;
}
