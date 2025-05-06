#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers.
Write a script to return the absolute difference between digit sum and element sum of the given array.

Example 1

Input: @ints = (1, 23, 4, 5)
Output: 18

Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18


Example 2

Input: @ints = (1, 2, 3, 4, 5)
Output: 0

Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0


Example 3

Input: @ints = (1, 2, 34)
Output: 27

Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27
=cut



use List::Util qw(sum);
use Test2::V0 -no_srand => 1;

is(sum_difference(1, 23, 4, 5), 18, 'Example 1');
is(sum_difference(1, 2, 3, 4, 5), 0, 'Example 2');
is(sum_difference(1, 2, 34), 27, 'Example 3');

done_testing();

sub sum_difference
{
     my @arr = @_;
     my $elm_sum = sum(@arr);
     my $digit_sum = sum( map { split(//, $_) } @arr );
     return abs($elm_sum - $digit_sum);
}
