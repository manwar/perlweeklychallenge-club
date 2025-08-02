#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they form the largest number and return it.
Example 1

Input: @ints = (20, 3)
Output: 320

Example 2

Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

=cut

use Test2::V0 -no_srand => 1;

is(largest_number(20, 3), 320, 'Example 1');
is(largest_number(3, 30, 34, 5, 9), 9534330, 'Example 2'); # WRONG!
done_testing();


sub largest_number 
{
     return '0' if @_ == grep { $_ == 0 } @_;
     return join('', sort { $b.$a <=> $a.$b } @_);
}