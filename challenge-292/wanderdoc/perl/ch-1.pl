#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.
Example 1

Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.

=cut

use List::Util qw(max first);
use List::MoreUtils qw(onlyidx);
use Test2::V0;

is(twice_largest(2, 4, 1, 0),  1, 'Example 1');
is(twice_largest(1, 2, 3, 4), -1, 'Example 2');
done_testing();


sub twice_largest
{
     my @arr = @_;
     my $max = max(@arr);
     my $max_idx = onlyidx { $_ == $max } @arr; # unique.
     die "The largest integer is not unique." if $max_idx == -1;
     splice(@arr, $max_idx, 1);
     return
          (defined first { $_ * 2 > $max  } @arr )
          ? -1
          : $max_idx;
}