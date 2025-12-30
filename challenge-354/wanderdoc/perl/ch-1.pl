#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of distinct integers.
Write a script to find all pairs of elements with the minimum absolute difference.

Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

Example 1

Input: @ints= (4, 2, 1, 3)
Output: [1, 2], [2, 3], [3, 4]


Example 2

Input: @ints = (10, 100, 20, 30)
Output: [10, 20], [20, 30]


Example 3

Input: @ints = (-5, -2, 0, 3)
Output: [-2, 0]


Example 4

Input: @ints = (8, 1, 15, 3)
Output: [1, 3]


Example 5

Input: @ints = (12, 5, 9, 1, 15)
Output: [9, 12], [12, 15]

=cut

use List::MoreUtils qw(slide indexes); # Strawberry 5.40.0
use List::Util qw(min);
use Test2::Bundle::More;


is_deeply(min_diff(4, 2, 1, 3), [[1, 2], [2, 3], [3, 4]], 'Example 1');
is_deeply(min_diff(10, 100, 20, 30), [[10, 20], [20, 30]], 'Example 2');
is_deeply(min_diff(-5, -2, 0, 3), [[-2, 0]], 'Example 3');
is_deeply(min_diff(8, 1, 15, 3), [[1, 3]], 'Example 4');
is_deeply(min_diff(12, 5, 9, 1, 15), [[9, 12], [12, 15]], 'Example 5');
done_testing();

sub min_diff
{
     my @arr = @_;
     @arr = sort {$a <=> $b } @arr;
     my @pairs = slide { [$a, $b] } @arr;
     my @diffs = slide { $b - $a  } @arr;
     my $min = min(@diffs);
     return [@pairs[indexes{$_ == $min} @diffs]];
}
